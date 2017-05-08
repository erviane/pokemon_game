class Skill < ApplicationRecord
		has_many :pokemon_skills
  		has_many :pokemons, through: :pokemon_skills

  		ELEMENT_TYPE = ['Normal','Fire','Fighting','Water','Flying','Grass','Poison','Ground','Psychic','Rock','Ice','Bug','Dragon','Ghost','Dark','Steel','Fairy']
  		
		validates :name, presence: true,
					length: {maximum: 45},
					uniqueness: true
		validates :power, numericality: { :greater_than => 0 }
		validates :max_pp, numericality: { :greater_than => 0 }
		validates :element_type, presence: true,
					length: {maximum: 45},
					inclusion: { in: ELEMENT_TYPE},
					allow_blank: false


		
end
