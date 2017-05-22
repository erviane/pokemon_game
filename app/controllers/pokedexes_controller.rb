class PokedexesController < ApplicationController
  before_action :set_pokedex, only: [:show, :edit, :update, :destroy]
  before_action :pokedex_select, only: [:new, :create, :edit, :update]

  # GET /pokedexes
  # GET /pokedexes.json
  def index
    @pokedexes = Pokedex.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokedexes/1
  # GET /pokedexes/1.json
  def show
  end

  # GET /pokedexes/new
  def new
    @pokedex = Pokedex.new
  end

  # GET /pokedexes/1/edit
  def edit
  end

  # POST /pokedexes
  # POST /pokedexes.json
  def create
    @pokedex = Pokedex.new(pokedex_params)
      if @pokedex.save
        redirect_to pokedexes_url
        flash[:success] = "New pokedex was successfully created"
      else
        render :new
      end
  end

  # PATCH/PUT /pokedexes/1
  # PATCH/PUT /pokedexes/1.json
  def update
      if @pokedex.update(pokedex_params)
        redirect_to pokedexes_url
        flash[:success] = "Pokedex was successfully updated"
      else
        render :edit
      end
  end

  # DELETE /pokedexes/1
  # DELETE /pokedexes/1.json
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
