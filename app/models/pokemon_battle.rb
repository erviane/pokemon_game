class PokemonBattle < ApplicationRecord
	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'
	has_many :pokemon_battle_logs, dependent: :delete_all

	STATES = %w[ongoing finish]
	BATTLE_TYPES = ["Manual Battle", "Player VS AI", "Auto Battle"]

	SORTS = {
		"match" => ["JOIN pokemons sort_p1 ON sort_p1.id = pokemon_battles.pokemon1_id", "sort_p1.name"],
		"mode" => "pokemon_battles.battle_type",
		"turn" => "pokemon_battles.current_turn",
		"status" => "pokemon_battles.state",
		"winner" => ["LEFT JOIN pokemons sort_winner ON sort_winner.id = pokemon_battles.pokemon_winner_id", "sort_winner.name"],
		"xp" => "pokemon_battles.experience_gain"
	}

	scope :search, ->(query) {
		next all if query.blank?
		joins("JOIN pokemons p1 ON p1.id = pokemon_battles.pokemon1_id JOIN pokemons p2 ON p2.id = pokemon_battles.pokemon2_id")
			.where("p1.name ILIKE :q OR p2.name ILIKE :q", q: contains_pattern(query))
	}
	scope :with_state, ->(state) { state.in?(STATES) ? where(state: state) : all }
	scope :of_battle_type, ->(type) { type.in?(BATTLE_TYPES) ? where(battle_type: type) : all }
	validates :pokemon1_id, presence: true,
							allow_blank: false
	validates :pokemon2_id, presence: true,
							allow_blank: false
	validates :current_turn, presence: true
	validates :state, presence: true
	validates :pokemon1_max_health_point, presence: true
	validates :pokemon2_max_health_point, presence: true
	validates :battle_type, presence: true
	validate :check_pokemon2
	validate :check_usable_skills, on: :create

	def self.ongoing_pokemon_ids
		where(state: "ongoing").pluck(:pokemon1_id, :pokemon2_id).flatten
	end

	# A Pokemon with no PP left can only surrender, so don't let it start a battle.
	def check_usable_skills
		{ pokemon1_id: pokemon1, pokemon2_id: pokemon2 }.each do |field, pokemon|
			next if pokemon.nil? || pokemon.pokemon_skills.where("current_pp > 0").exists?
			errors.add(field, :no_usable_skills, name: pokemon.name)
		end
	end

	def check_pokemon2
  		errors.add(:pokemon2_id, :same_as_pokemon1) if pokemon1_id.present? && pokemon2_id == pokemon1_id
	end

	def pokemon1_name
		pokemon1.name	
	end

	def pokemon2_name
		pokemon2.name		
	end

	def winner
		Pokemon.find(pokemon_winner_id).name unless pokemon_winner_id.nil?
	end	

	def loser
		Pokemon.find(pokemon_loser_id).name unless pokemon_winner_id.nil?
	end

end
