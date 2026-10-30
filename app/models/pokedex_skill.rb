class PokedexSkill < ApplicationRecord
	belongs_to :pokedex
	belongs_to :skill

	validates :skill_id, uniqueness: { scope: :pokedex_id, message: :already_in_learnset }
	validates :learn_level, numericality: { only_integer: true, greater_than: 0 }
	validate :check_starting_skill
	before_destroy :keep_starting_skill

	private

	# New Pokemon start with the level 1 skills, so a learnset without one leaves them unable to battle.
	def check_starting_skill
		return if learn_level == 1 || pokedex.nil?
		errors.add(:learn_level, :no_starting_skill) unless other_entries.exists?(learn_level: 1)
	end

	# Emptying the whole learnset is fine: the species then falls back to every skill.
	def keep_starting_skill
		return if learn_level_was != 1 || other_entries.none? || other_entries.exists?(learn_level: 1)
		errors.add(:base, :last_starting_skill)
		throw :abort
	end

	def other_entries
		pokedex.pokedex_skills.where.not(id: id)
	end
end
