class PokedexSkillsController < ApplicationController
	before_action :set_pokedex

	def create
		pokedex_skill = @pokedex.pokedex_skills.new(params.permit(:skill_id, :learn_level))
		if pokedex_skill.save
			flash[:success] = t("flash.pokedex_skills.added", skill: pokedex_skill.skill.name, level: pokedex_skill.learn_level)
		else
			flash[:danger] = pokedex_skill.errors.full_messages.first
		end
		redirect_to pokedex_path(@pokedex, anchor: "learnset")
	end

	def destroy
		pokedex_skill = @pokedex.pokedex_skills.find(params[:id])
		if pokedex_skill.destroy
			flash[:success] = t("flash.pokedex_skills.removed", skill: pokedex_skill.skill.name)
		else
			flash[:danger] = pokedex_skill.errors.full_messages.first
		end
		redirect_to pokedex_path(@pokedex, anchor: "learnset")
	end

	private

	def set_pokedex
		@pokedex = Pokedex.find(params[:pokedex_id])
	end
end
