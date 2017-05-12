class PokemonBattleCalculator
	ARRAY_OF_BATTLE_TYPES = {
		normal: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 0.5,
			bug: 1,
			ghost: 0,
			steel: 0.5,
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
			flying: 0.5,
			poison: 0.5,
			ground: 1,
			rock: 2,
			bug: 0.5,
			ghost: 0,
			steel: 2,
			fire: 1,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 0.5,
			ice: 2,
			dragon: 1,
			dark: 2,
			fairy: 0.5
		},
		flying: {
			normal: 1,
			fighting: 2,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 0.5,
			bug: 2,
			ghost: 1,
			steel: 0.5,
			fire: 1,
			water: 1,
			grass: 2,
			electric: 0.5,
			psychic: 1,
			ice: 1,
			dragon: 1,
			dark: 1,
			fairy: 1
		},
		poison: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 0.5,
			ground: 0.5,
			rock: 0.5,
			bug: 1,
			ghost: 0.5,
			steel: 0,
			fire: 1,
			water: 1,
			grass: 2,
			electric: 1,
			psychic: 1,
			ice: 1,
			dragon: 1,
			dark: 1,
			fairy: 2
		},
		ground: {
			normal: 1,
			fighting: 1,
			flying: 0,
			poison: 2,
			ground: 1,
			rock: 2,
			bug: 0.5,
			ghost: 1,
			steel: 2,
			fire: 2,
			water: 1,
			grass: 0.5,
			electric: 2,
			psychic: 1,
			ice: 1,
			dragon: 1,
			dark: 1,
			fairy: 1
		},
		rock: {
			normal: 1,
			fighting: 0.5,
			flying: 2,
			poison: 1,
			ground: 0.5,
			rock: 1,
			bug: 2,
			ghost: 1,
			steel: 0.5,
			fire: 2,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 1,
			ice: 2,
			dragon: 1,
			dark: 1,
			fairy: 1
		},
		bug: {
			normal: 1,
			fighting: 0.5,
			flying: 0.5,
			poison: 0.5,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 0.5,
			steel: 0.5,
			fire: 0.5,
			water: 1,
			grass: 2,
			electric: 1,
			psychic: 2,
			ice: 1,
			dragon: 1,
			dark: 2,
			fairy: 0.5
		},
		ghost: {
			normal: 0,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 2,
			steel: 1,
			fire: 1,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 2,
			ice: 1,
			dragon: 1,
			dark: 0.5,
			fairy: 1
		},
		steel: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 2,
			bug: 1,
			ghost: 1,
			steel: 0.5,
			fire: 0.5,
			water: 0.5,
			grass: 1,
			electric: 0.5,
			psychic: 1,
			ice: 2,
			dragon: 1,
			dark: 1,
			fairy: 2
		},
		fire: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 1,
			rock:0.5,
			bug: 2,
			ghost: 1,
			steel: 2,
			fire: 0.5,
			water: 0.5,
			grass: 2,
			electric: 1,
			psychic: 1,
			ice: 2,
			dragon: 0.5,
			dark: 1,
			fairy: 1
		},
		water: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 2,
			rock: 2,
			bug: 1,
			ghost: 1,
			steel: 1,
			fire: 2,
			water: 0.5,
			grass: 0.5,
			electric: 1,
			psychic: 1,
			ice: 1,
			dragon: 0.5,
			dark: 1,
			fairy: 1
		},
		grass: {
			normal: 1,
			fighting: 1,
			flying: 0.5,
			poison: 0.5,
			ground: 2,
			rock: 2,
			bug: 0.5,
			ghost: 1,
			steel: 0.5,
			fire: 0.5,
			water: 2,
			grass: 0.5,
			electric: 1,
			psychic: 1,
			ice: 1,
			dragon: 0.5,
			dark: 1,
			fairy: 1
		},
		electric: {
			normal: 1,
			fighting: 1,
			flying: 2,
			poison: 1,
			ground: 0,
			rock: 1,
			bug: 1,
			ghost: 1,
			steel: 1,
			fire: 1,
			water: 2,
			grass: 0.5,
			electric: 0.5,
			psychic: 1,
			ice: 1,
			dragon: 0.5,
			dark: 1,
			fairy: 1
		},
		psychic: {
			normal: 1,
			fighting: 2,
			flying: 1,
			poison: 2,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 1,
			steel: 0.5,
			fire: 1,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 0.5,
			ice: 1,
			dragon: 1,
			dark: 0,
			fairy: 1
		},
		ice: {
			normal: 1,
			fighting: 1,
			flying: 2,
			poison: 1,
			ground: 2,
			rock: 1,
			bug: 1,
			ghost: 1,
			steel: 0.5,
			fire: 0.5,
			water: 0.5,
			grass: 2,
			electric: 1,
			psychic: 1,
			ice: 0.5,
			dragon: 2,
			dark: 1,
			fairy: 1
		},
		dragon: {
			normal: 1,
			fighting: 1,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 1,
			steel: 0.5,
			fire: 1,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 1,
			ice: 1,
			dragon: 2,
			dark: 1,
			fairy: 0
		},
		dark: {
			normal: 1,
			fighting: 0.5,
			flying: 1,
			poison: 1,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 2,
			steel: 1,
			fire: 1,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 2,
			ice: 1,
			dragon: 1,
			dark: 0.5,
			fairy: 0.5
		},
		fairy: {
			normal: 1,
			fighting: 2,
			flying: 1,
			poison: 0.5,
			ground: 1,
			rock: 1,
			bug: 1,
			ghost: 1,
			steel: 0.5,
			fire: 0.5,
			water: 1,
			grass: 1,
			electric: 1,
			psychic: 1,
			ice: 1,
			dragon: 2,
			dark: 2,
			fairy: 1
		}

	}

	
	def self.calculate_damage(attacker, defender, skill)
		skill_element_type = skill.element_type
		attacker_element_type = attacker.element_type
		defender_element_type = defender.element_type

		stab = if skill_element_type == defender_element_type
			1.5
		else
			1
		end

		attacker_symbol = attacker_element_type.downcase.to_sym
		defender_symbol = defender_element_type.downcase.to_sym
		weakness_resistance = ARRAY_OF_BATTLE_TYPES[attacker_symbol][defender_symbol]

		damage = ((((2 * attacker.level / 5.to_f + 2) * attacker.attack * skill.power / defender.defence.to_f) / 50.to_f) + 2) * stab * weakness_resistance * ( rand(85..100) / 100.to_f)

	end

	def self.calculate_experience(enemy_level)
		rand(20..150)*enemy_level		
	end

	def self.level_up?(level_winner, total_experience_winner)
		max_exp = 2**level_winner*100
		if total_experience_winner >= max_exp
			return true
		else
			return false
		end		
	end

	def self.calculate_level_up_extra_stats
		health_point = rand(10..20)
		attack_point = rand(1..5)
		defence_point = rand(1..5)
		speed_point = rand(1..5)
		extra_point = Struct.new(:health, :attack, :defence, :speed)
		winner_extra_point = extra_point.new(health_point, attack_point, defence_point, speed_point)
	end
end