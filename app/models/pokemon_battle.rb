class PokemonBattle < ApplicationRecord
	belongs_to :pokemon
	validates :pokemon1_id, presence: true, allow_blank: false
	validates :pokemon2_id, presence: true, allow_blank: false
	validates :current_turn, presence: true
	validates :state, presence: true
	validates :pokemon1_max_health_point, presence: true
	validates :pokemon2_max_health_point, presence: true
end
