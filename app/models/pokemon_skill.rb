class PokemonSkill < ApplicationRecord
	belongs_to :pokemon
	belongs_to :skill
	validates :pokemon_id, presence: true
	validates :current_pp, numericality: { :greater_than_or_equal_to => 0}
	validates :skill_id, :uniqueness => {:scope => :pokemon_id}
	validate :check_current_pp

	def check_current_pp
		errors.add(:current_pp, "should be greater than or equal to skill max PP") if current_pp.to_i > skill_max_pp.to_i
	end

	def skill_name
		skill.name
	end

	def skill_power
		skill.power
	end

	def skill_max_pp
		skill.max_pp
	end

	def skill_element_type
		skill.element_type		
	end
end
