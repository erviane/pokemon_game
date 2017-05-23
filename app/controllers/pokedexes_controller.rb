class PokedexesController < ApplicationController
    before_action :set_pokedex, only: [:show, :edit, :update, :destroy]
    before_action :pokedex_select, only: [:new, :create, :edit, :update]  

    def index
        @pokedexes = Pokedex.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
    end 

    def show
    end 

    def new
        @pokedex = Pokedex.new
    end 

    def edit
    end 

    def create
        @pokedex = Pokedex.new(pokedex_params)
        if @pokedex.save
          redirect_to pokedexes_url
          flash[:success] = "New pokedex was successfully created"
        else
          render :new
        end
    end 

    def update
        if @pokedex.update(pokedex_params)
          redirect_to pokedexes_url
          flash[:success] = "Pokedex was successfully updated"
        else
          render :edit
        end
    end 

    def destroy
      @pokedex.destroy
        redirect_to pokedexes_url
        flash[:success] = "Pokedex was successfully destroyed"
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
