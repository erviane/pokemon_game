require "csv"
require "json"
require "net/http"

namespace :pokemon_rainbow do
  desc "Fetch level-up learnsets from PokeAPI into lib/seeds/list_learnset.csv"
  task :fetch_learnset do
    version_group = ENV.fetch("VERSION_GROUP", "ultra-sun-ultra-moon")
    seeds = Rails.root.join("lib", "seeds")
    skills = CSV.read(seeds.join("list_skill.csv"), headers: true).map { |r| r["name"] }.to_set
    pokedexes = CSV.read(seeds.join("list_pokedex.csv"), headers: true).map { |r| r["name"] }

    queue = Queue.new
    pokedexes.each { |name| queue << name }
    rows, missing, lock = [], [], Mutex.new

    # A few threads keep the ~800 requests to a couple of minutes without hammering PokeAPI.
    Array.new(6) do
      Thread.new do
        while (name = queue.pop(true) rescue nil)
          res = Net::HTTP.get_response(URI("https://pokeapi.co/api/v2/pokemon/#{name}"))
          unless res.is_a?(Net::HTTPSuccess) # e.g. "pyroar" only exists as "pyroar-male"
            species = Net::HTTP.get_response(URI("https://pokeapi.co/api/v2/pokemon-species/#{name}"))
            res = Net::HTTP.get_response(URI(JSON.parse(species.body)["varieties"].first["pokemon"]["url"])) if species.is_a?(Net::HTTPSuccess)
          end
          next lock.synchronize { missing << name } unless res.is_a?(Net::HTTPSuccess)

          learnset = {}
          JSON.parse(res.body)["moves"].each do |move|
            next unless skills.include?(move["move"]["name"])
            move["version_group_details"].each do |d|
              next unless d["version_group"]["name"] == version_group && d["move_learn_method"]["name"] == "level-up"
              level = [d["level_learned_at"], 1].max # level 0 = learned on evolution
              learnset[move["move"]["name"]] = [learnset[move["move"]["name"]], level].compact.min
            end
          end
          # Every species needs a skill at level 1 to battle, so the earliest one is moved there.
          if learnset.any? && learnset.values.min > 1
            first = learnset.min_by { |_, level| level }.first
            learnset[first] = 1
          end
          lock.synchronize { learnset.each { |skill, level| rows << [name, skill, level] } }
        end
      end
    end.each(&:join)

    order = pokedexes.each_with_index.to_h
    CSV.open(seeds.join("list_learnset.csv"), "w") do |csv|
      csv << %w[pokedex_name skill_name learn_level]
      rows.sort_by { |p, s, l| [order[p], l, s] }.each { |row| csv << row }
    end
    puts "#{rows.size} learnset rows for #{rows.map(&:first).uniq.size}/#{pokedexes.size} Pokedex"
    puts "Not found on PokeAPI: #{missing.sort.join(', ')}" if missing.any?
  end
end
