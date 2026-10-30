class Skill < ApplicationRecord
		has_many :pokemon_skills, dependent: :destroy
  		has_many :pokemons, through: :pokemon_skills, dependent: :destroy
  		has_many :pokemon_battle_logs, dependent: :destroy

  		SORTS = { "name" => "skills.name", "type" => "skills.element_type", "power" => "skills.power", "max_pp" => "skills.max_pp" }

  		scope :search, ->(query) { query.present? ? where("skills.name ILIKE ?", contains_pattern(query)) : all }
  		scope :of_type, ->(type) { type.present? ? where(element_type: type) : all }

  		ELEMENT_TYPE = ['Normal','Fire','Fighting','Water','Flying','Grass','Poison','Ground','Psychic','Rock','Ice','Bug','Dragon','Ghost','Dark','Steel','Fairy','Electric']
  		
		validates :name, presence: true,
					length: {maximum: 45},
					uniqueness: true
		validates :power, numericality: { :greater_than => 0 }
		validates :max_pp, numericality: { :greater_than => 0 }
		validates :element_type, presence: true,
					inclusion: { in: ELEMENT_TYPE, allow_blank: true }


		
end
