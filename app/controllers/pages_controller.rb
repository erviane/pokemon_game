class PagesController < ApplicationController
	def index
		if params[:element_type].present?
			@element_type = params[:element_type]
		else
			@element_type = "Normal"
		end
		#element type NORMAL
		sql_most_win_pokemon = ActiveRecord::Base.connection.execute("select pokemons.name, count(pokemon_battles.pokemon_winner_id) as pokemon_winner 
																	from pokemons left outer join pokemon_battles 
																	on pokemons.id = pokemon_battles.pokemon_winner_id
																	left outer join pokedexes
																	on pokemons.pokedex_id = pokedexes.id
																	where pokedexes.element_type = '#{@element_type}' 
																	group by pokemons.id
																	order by pokemon_winner desc, pokemons.level desc 
																	limit 5")
		@most_win_pokemon ={}
		sql_most_win_pokemon.each do |x| 
			x_name = x['name']
			@most_win_pokemon["#{x_name}"] = x['pokemon_winner']
		end

		sql_most_lose_pokemon = ActiveRecord::Base.connection.execute("select pokemons.name, count(pokemon_battles.pokemon_loser_id) as pokemon_loser 
																		from pokemons left outer join pokemon_battles 
																		on pokemons.id = pokemon_battles.pokemon_loser_id 
																		left outer join pokedexes
																		on pokemons.pokedex_id = pokedexes.id
																		where pokedexes.element_type = '#{@element_type}'
																		group by pokemons.id 
																		order by pokemon_loser desc, pokemons.level desc 
																		limit 5")
		@most_lose_pokemon ={}
		sql_most_lose_pokemon.each do |x| 
			x_name = x['name']
			@most_lose_pokemon["#{x_name}"] = x['pokemon_loser']
		end

		sql_most_used_skill = ActiveRecord::Base.connection.execute("select skills.name, count(pokemon_battle_logs.skill_id) as used_skill 
																	from skills left outer join pokemon_battle_logs 
																	on skills.id = pokemon_battle_logs.skill_id
																	where skills.element_type = '#{@element_type}' 
																	group by skills.id 
																	order by used_skill desc
																	limit 5")
		@most_used_skill ={}
		sql_most_used_skill.each do |x| 
			x_name = x['name']
			@most_used_skill["#{x_name}"] = x['used_skill']
		end

		sql_most_pokemon_picked = ActiveRecord::Base.connection.execute("select name, sum(count) as sum_picked 
																		from (
																				select pokemons.name, count(pokemon_battles.pokemon1_id)
																				from pokemons left outer join pokemon_battles
																				on pokemons.id = pokemon_battles.pokemon1_id
																				left outer join pokedexes
																				on pokemons.pokedex_id = pokedexes.id
																				where pokedexes.element_type = '#{@element_type}' 
																				group by pokemons.id
																				UNION 
																				select pokemons.name, count(pokemon_battles.pokemon2_id)
																				from pokemons left outer join pokemon_battles 
																				on pokemons.id = pokemon_battles.pokemon2_id
																				left outer join pokedexes
																				on pokemons.pokedex_id = pokedexes.id
																				where pokedexes.element_type = '#{@element_type}' 
																				group by pokemons.id
																			) 
																		as pokemon_picked 
																		group by name 
																		order by sum_picked desc
																		limit 5")
		@most_pokemon_picked ={}
		sql_most_pokemon_picked.each do |x| 
			x_name = x['name']
			@most_pokemon_picked["#{x_name}"] = x['sum_picked']
		end

		sql_most_surrender_pokemon = ActiveRecord::Base.connection.execute("select pokemons.name, count(pokemon_battle_logs.action_type) as battle_action 
																			from pokemons left outer join pokemon_battle_logs 
																			on pokemons.id = pokemon_battle_logs.attacker_id
																			left outer join pokedexes
																			on pokemons.pokedex_id = pokedexes.id
																			where pokemon_battle_logs.action_type = 'surrender'
																			and pokedexes.element_type = '#{@element_type}'
																			group by pokemons.id 
																			order by battle_action desc, pokemons.level desc
																			limit 5")
		@most_surrender_pokemon ={}
		sql_most_surrender_pokemon.each do |x| 
			x_name = x['name']
			@most_surrender_pokemon["#{x_name}"] = x['battle_action']
		end
	end
end
