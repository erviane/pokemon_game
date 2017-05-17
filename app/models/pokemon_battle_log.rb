class PokemonBattleLog < ApplicationRecord
	belongs_to :pokemon_battle
	belongs_to :skill
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
