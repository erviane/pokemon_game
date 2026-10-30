class Pokemon < ApplicationRecord
	belongs_to :pokedex
	has_many :pokemon_skills, dependent: :destroy

	scope :search, ->(query) { query.present? ? joins(:pokedex).where("pokemons.name ILIKE :q OR pokedexes.name ILIKE :q", q: contains_pattern(query)) : all }
	scope :of_type, ->(type) { type.present? ? joins(:pokedex).where(pokedexes: { element_type: type }) : all }
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
	after_create :learn_starting_skills
	
	def check_current_health_point
  		errors.add(:current_health_point, :exceeds_max_hp) if current_health_point.to_i > max_health_point.to_i
	end

	def check_pokedex_id
		errors.add(:pokedex_id, :blank) if self.pokedex_id.blank?		
	end

	def element_type
		pokedex.element_type
	end

	def learnable_skills
		Skill.joins(:pokedex_skills).where(pokedex_skills: { pokedex_id: pokedex_id }).where("pokedex_skills.learn_level <= ?", level)
	end

	private

	def learn_starting_skills
		learnable_skills.order("skills.power DESC").limit(4).each do |skill|
			pokemon_skills.create(skill: skill, current_pp: skill.max_pp)
		end
	end
end 
