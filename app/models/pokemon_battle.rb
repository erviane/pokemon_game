class PokemonBattle < ApplicationRecord
	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'
	validates :pokemon1_id, presence: true,
							allow_blank: false
	validates :pokemon2_id, presence: true,
							allow_blank: false
	validates :current_turn, presence: true
	validates :state, presence: true
	validates :pokemon1_max_health_point, presence: true
	validates :pokemon2_max_health_point, presence: true
	validate :check_pokemon2

	def check_pokemon2
  		errors.add(:pokemon2_id, "Pokemon 2 can't same as pokemon 1") if pokemon2_id == pokemon1_id
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
