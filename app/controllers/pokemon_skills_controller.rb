class PokemonSkillsController < ApplicationController
	before_action :set_pokemon_skill, only: [:destroy]

	def destroy
		@pokemon_skill.destroy
		flash[:success] = t("flash.pokemon_skills.forgot", pokemon: @pokemon_skill.pokemon.name, skill: @pokemon_skill.skill_name)
      	redirect_back fallback_location: pokemon_path(@pokemon_skill.pokemon_id)
	end

	def create
		@pokemon_skill = PokemonSkill.new(pokemon_skill_params)
		if Skill.ids.include?params[:skill_id].to_i
			skill = Skill.find(params[:skill_id])
			current_pp = skill.max_pp
			pokemon_id = params[:pokemon_id]
			@pokemon_skill.pokemon_id = pokemon_id
			@pokemon_skill.current_pp = current_pp
			if 	@pokemon_skill.save		
				flash[:success] = t("flash.pokemon_skills.learned", pokemon: @pokemon_skill.pokemon.name, skill: skill.name)
			else
				flash[:danger] = @pokemon_skill.errors.full_messages.first
			end
		else
			flash[:danger] = t("flash.pokemon_skills.choose_skill")
		end
		redirect_back fallback_location: pokemon_path(params[:pokemon_id])

	end

	private

	def pokemon_skill_params
		params.permit(:skill_id)
	end

	def set_pokemon_skill
		@pokemon_skill = PokemonSkill.find(params[:id])	
	end
end
