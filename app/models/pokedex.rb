class Pokedex < ApplicationRecord
	has_many :pokemons, dependent: :destroy

	scope :search, ->(query) { query.present? ? where("pokedexes.name ILIKE ?", contains_pattern(query)) : all }
	scope :of_type, ->(type) { type.present? ? where(element_type: type) : all }
	validates :name, presence: true,
					length: {maximum: 45},
					uniqueness: true
	validates :base_health_point, numericality: { :greater_than => 0 }
	validates :base_attack,numericality: { :greater_than => 0 }
	validates :base_defence, numericality: { :greater_than => 0 }
	validates :base_speed, numericality: { :greater_than_or_equal_to => 0 }
	validates :element_type, presence: true,
							inclusion: {in: Skill::ELEMENT_TYPE, allow_blank: true}
end
