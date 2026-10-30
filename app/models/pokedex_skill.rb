class PokedexSkill < ApplicationRecord
	belongs_to :pokedex
	belongs_to :skill

	validates :skill_id, uniqueness: { scope: :pokedex_id, message: :already_in_learnset }
	validates :learn_level, numericality: { only_integer: true, greater_than: 0 }
end
