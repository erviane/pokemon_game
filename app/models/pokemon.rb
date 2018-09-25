class Pokemon < ApplicationRecord
	belongs_to :pokedex
	belongs_to :trainer
	has_many :pokemon_skills, dependent: :destroy
  	has_many :skills, through: :pokemon_skills, dependent: :destroy
  	has_many :pokemon_battles, foreign_key: :pokemon1_id, dependent: :destroy
  	has_many :pokemon_battles, foreign_key: :pokemon2_id, dependent: :destroy
	validates :name, presence: true,
						length: {maximum: 45},
						uniqueness: true
	validates :pokedex_id, presence: true, 
							allow_blank: false
	validates :current_health_point, numericality: { :greater_than_or_equal_to => 0}									
	validates :current_experience, numericality: { :greater_than_or_equal_to => 0 }
	validates :max_health_point, numericality: { :greater_than => 0 }
	validates :attack, numericality: { :greater_than => 0 }
	validates :defence, numericality: { :greater_than => 0 }
	validates :speed, numericality: { :greater_than => 0 }
	validates :level, numericality: { :greater_than => 0 }
	validate :check_current_health_point
	validate :check_pokedex_id
	
	def check_current_health_point
  		errors.add(:current_health_point, "should be greater than or equal to max health point") if current_health_point.to_i > max_health_point.to_i
	end

	def check_pokedex_id
		errors.add(:pokedex_id, "can't be blank") if self.pokedex_id.blank?		
	end

	def element_type
		pokedex.element_type
	end
end 
