class Pokemon < ApplicationRecord
	belongs_to :pokedex
	has_many :pokemon_skills, dependent: :destroy
  	has_many :skills, through: :pokemon_skills
  	
	validates :name, presence: true,
						length: {maximum: 45},
						uniqueness: true
	validates :pokedex_id, presence: true
	validates :current_health_point, numericality: { :greater_than_or_equal_to => 0}									
	validates :current_experience, numericality: { :greater_than_or_equal_to => 0 }
	validates :max_health_point, numericality: { :greater_than => 0 }
	validates :attack, numericality: { :greater_than => 0 }
	validates :defence, numericality: { :greater_than => 0 }
	validates :speed, numericality: { :greater_than => 0 }
	validates :level, numericality: { :greater_than => 0 }
	validate :check_current_health_point

	def check_current_health_point
  		errors.add(:current_health_point, "should be greater than or equal to max health point") if current_health_point.to_i > max_health_point.to_i
	end
end 
