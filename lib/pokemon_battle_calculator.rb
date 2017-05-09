class PokemonBattleCalculator
	class << self
		ARRAY_OF_BATTLE_TYPES = {
			normal: {
				normal: 1,
				fighting: 1,
				flying: 1,
				poison: 1,
				ground: 1,
				rock: 1.5,
				bug: 1,
				ghost: 0,
				steel: 1.5,
				fire: 1,
				water: 1,
				grass: 1,
				electric: 1,
				psychic: 1,
				ice: 1,
				dragon: 1,
				dark: 1,
				fairy: 1	

			},
			fighting: {
				normal: 2,
				fighting: 1,
				flying: 1.5,
				poison: 1.5,
				ground: 1,
				rock: 2,
				bug: 1.5,
				ghost: 0,
				steel: 2,
				fire: 1,
				water: 1,
				grass: 1,
				electric: 1,
				psychic: 1.5,
				ice: 2,
				dragon: 1,
				dark: 2,
				fairy: 1.5
			},
			flying: {
				normal: 1,
				fighting: 2,
				flying: 1,
				poison: 1,
				ground: 1,
				rock: 1.5,
				bug: 2,
				ghost: 1,
				steel: 1.5,
				fire: 1,
				water: 1,
				grass: 2,
				electric: 1.5,
				psychic: 1,
				ice: 1,
				dragon: 1,
				dark: 1,
				fairy: 1
			}
		}
		
		def calculate_damage(attacker_id, defender_id, skill_id)
			result = 0
			@pokemon_attacker = Pokemon.find(attacker_id)
			@pokemon_defender = Pokemon.find(defender_id)
			@skill = Skill.find(skill_id)
			damage = ((((2 * @pokemon_attacker.level / 5.to_f + 2) * @pokemon_attacker.attack * @skill.power / @pokemon_defender.defence.to_f) / 50.to_f) + 2) * stab * weakness_resistance * ( random_number / 100.to_f)
			result = damage.to_i
			puts result
		end	

		private	

		def random_number
			rand(85..100)	
		end	

		def stab
			@pokemon_attacker_element_type = @pokemon_attacker.pokedex.element_type
			@pokemon_defender_element_type = @pokemon_defender.pokedex.element_type
			if @pokemon_attacker_element_type == @pokemon_defender_element_type
				return 1.5
			else
				return 1
			end
		end	

		def weakness_resistance
			@pokemon_attacker_symbol = @pokemon_attacker_element_type.downcase.to_sym
			@pokemon_defender_symbol = @pokemon_defender_element_type.downcase.to_sym
			return ARRAY_OF_BATTLE_TYPES[@pokemon_attacker_symbol][@pokemon_defender_symbol]
		end
	end
end
