class PokemonSkill < ApplicationRecord
	belongs_to :pokemon
	belongs_to :skill

	SORTS = { "name" => "skills.name", "type" => "skills.element_type", "power" => "skills.power", "pp" => "pokemon_skills.current_pp" }
	validates :pokemon_id, presence: true
	validates :current_pp, numericality: { :greater_than_or_equal_to => 0}
	validates :skill_id, presence: true, 
						allow_blank: false, 
						:uniqueness => {:scope => :pokemon_id, :message => :already_known}
	validate :check_current_pp
	validate :max_skill_have, on: :create
	validate :check_learnable, on: :create

	def max_skill_have
		errors.add(:pokemon_id, :too_many_skills) if pokemon && pokemon.pokemon_skills.count >= 4
	end

	# Only checked when learning, so skills known before learnsets existed are kept.
	def check_learnable
		return if pokemon.nil? || skill_id.nil?
		entry = pokemon.pokedex.pokedex_skills.find_by(skill_id: skill_id)
		if entry.nil?
			errors.add(:skill_id, :not_in_learnset, pokemon: pokemon.pokedex.name.capitalize)
		elsif entry.learn_level > pokemon.level
			errors.add(:skill_id, :level_too_low, level: entry.learn_level)
		end
	end

	def check_current_pp
		errors.add(:current_pp, :exceeds_max_pp) if current_pp.to_i > skill_max_pp.to_i
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
