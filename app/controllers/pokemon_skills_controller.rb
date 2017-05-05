class PokemonSkillsController < ApplicationController
	before_action :set_pokemon_skill, only: [:destroy]

	def destroy
		@pokemon_skill.destroy
      	redirect_to :back	
	end

	def create
		@pokemon_skill = PokemonSkill.new(pokemon_skill_params)
		skill = Skill.find(params[:skill_id])
		current_pp = skill.max_pp
		pokemon_id = params[:pokemon_id]
		@pokemon_skill.pokemon_id = pokemon_id
		@pokemon_skill.current_pp = current_pp
		if 	@pokemon_skill.save		
			redirect_to :back			
		else
			@errors = @pokemon_skill.errors.full_messages.to_sentence
			flash[:danger] = @errors
			redirect_to :back
		end

	end

	private

	def pokemon_skill_params
		params.permit(:skill_id)
	end

	def set_pokemon_skill
		@pokemon_skill = PokemonSkill.find(params[:id])	
	end
end
