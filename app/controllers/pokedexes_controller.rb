class PokedexesController < ApplicationController
    before_action :set_pokedex, only: [:show, :edit, :update, :destroy]
    before_action :pokedex_select, only: [:new, :create, :edit, :update]  

    def index
        @pokedexes = Pokedex.search(params[:q]).of_type(params[:type]).order("pokedexes.created_at DESC").paginate(page: params[:page], per_page: 20)
    end 

    def show
        @learnset = @pokedex.pokedex_skills.includes(:skill).order(:learn_level, "skills.name").references(:skill)
        @skill_select = Skill.where.not(id: @learnset.map(&:skill_id)).order(:name).map {|p| [ t("pokemons.skill_option", name: p.name, type: p.element_type, power: p.power), p.id ] }
    end 

    def new
        @pokedex = Pokedex.new
    end 

    def edit
    end 

    def create
        @pokedex = Pokedex.new(pokedex_params)
        if @pokedex.save
          redirect_to pokedex_url(@pokedex)
          flash[:success] = t("flash.pokedexes.created")
        else
          render :new, status: :unprocessable_entity
        end
    end 

    def update
        if @pokedex.update(pokedex_params)
          redirect_to pokedex_url(@pokedex)
          flash[:success] = t("flash.pokedexes.updated")
        else
          render :edit, status: :unprocessable_entity
        end
    end 

    def destroy
      @pokedex.destroy
        redirect_to pokedexes_url
        flash[:success] = t("flash.pokedexes.deleted")
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokedex
      @pokedex = Pokedex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end

    def pokedex_select
      @pokedex_select = Skill::ELEMENT_TYPE.collect {|p| [ p, p ]}
    end
end
