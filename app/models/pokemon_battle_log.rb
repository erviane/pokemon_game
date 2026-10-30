class PokemonBattleLog < ApplicationRecord
	belongs_to :pokemon_battle
	belongs_to :skill

	ACTION_TYPES = %w[attack surrender]

	SORTS = {
		"turn" => "pokemon_battle_logs.turn",
		"attacker" => ["JOIN pokemons sort_attacker ON sort_attacker.id = pokemon_battle_logs.attacker_id", "sort_attacker.name"],
		"action" => "pokemon_battle_logs.action_type",
		"skill" => ["LEFT JOIN skills sort_skill ON sort_skill.id = pokemon_battle_logs.skill_id", "sort_skill.name"],
		"damage" => "pokemon_battle_logs.damage",
		"defender" => ["JOIN pokemons sort_defender ON sort_defender.id = pokemon_battle_logs.defender_id", "sort_defender.name"],
		"hp_left" => "pokemon_battle_logs.defender_current_health_point"
	}

	scope :search, ->(query) {
		next all if query.blank?
		joins("JOIN pokemons attackers ON attackers.id = pokemon_battle_logs.attacker_id JOIN pokemons defenders ON defenders.id = pokemon_battle_logs.defender_id")
			.left_joins(:skill)
			.where("attackers.name ILIKE :q OR defenders.name ILIKE :q OR skills.name ILIKE :q", q: contains_pattern(query))
	}
	scope :with_action, ->(action) { action.in?(ACTION_TYPES) ? where(action_type: action) : all }
	validates :pokemon_battle_id, presence: true
	validates :turn, presence: true
	validates :attacker_id, presence: true
	validates :attacker_current_health_point, presence: true
	validates :defender_id, presence: true
	validates :defender_current_health_point, presence: true
	validates :action_type, presence: true,
							length: {maximum: 45}

	def attacker_name
		Pokemon.find(attacker_id).name
	end

	def defender_name
		Pokemon.find(defender_id).name
	end
end
