class Pokedex < ApplicationRecord
	has_many :pokemons, dependent: :destroy
	validates :name, presence: true,
					length: {maximum: 45},
					uniqueness: true
	validates :base_health_point, numericality: { :greater_than => 0 }
	validates :base_attack,numericality: { :greater_than => 0 }
	validates :base_defence, numericality: { :greater_than => 0 }
	validates :base_speed, numericality: { :greater_than => 0 }
	validates :element_type, presence: true,
							length: {maximum: 45},
							inclusion: {in: Skill::ELEMENT_TYPE, :message => "The value is not included in the list"},
							allow_blank: false
	 validate :check_element_type

	def check_element_type
		errors.add(:element_type, "can't be blank") if self.element_type.blank?		
	end
end
