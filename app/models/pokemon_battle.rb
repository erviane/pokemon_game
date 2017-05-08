class PokemonBattle < ApplicationRecord
	belongs_to :pokemon
	validates :pokemon1_id, presence: true, allow_blank: false
	validates :pokemon2_id, presence: true, allow_blank: false
	validates :current_turn, presence: true
	validates :state, presence: true
	validates :pokemon1_max_health_point, presence: true
	validates :pokemon2_max_health_point, presence: true
	validate :check_pokemon1
	validate :check_pokemon2

	def check_pokemon1
		errors.add(:pokemon1_id, "can't be blank") if self.pokemon1_id.blank?		
	end

	def check_pokemon2
		errors.add(:pokemon2_id, "can't be blank") if self.pokemon2_id.blank?		
	end
end
