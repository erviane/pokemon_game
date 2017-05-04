class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    @pokemons = Pokemon.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
    @pokedex = Pokedex.all
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons
  # POST /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)

    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to pokemons_url
        flash[:success] = "New pokemon was successfully created"  }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :new }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemons/1
  # PATCH/PUT /pokemons/1.json
  def update
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to pokemons_url
        flash[:success] = "Pokemon was successfully updated"  }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    @pokemon.destroy
    respond_to do |format|
      format.html { redirect_to pokemons_url
      flash[:success] = "Pokemon was successfully deleted"  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params
      pokedex = Pokedex.find(params[:pokemon][:pokedex_id])
      params[:pokemon][:max_health_point] = pokedex.base_health_point
      params[:pokemon][:current_health_point] = pokedex.base_health_point
      params[:pokemon][:attack] = pokedex.base_attack
      params[:pokemon][:defence] = pokedex.base_defence
      params[:pokemon][:speed] = pokedex.base_speed
      params[:pokemon][:current_experience] = 1
      params[:pokemon][:level] = 1
      x = params.require(:pokemon).permit(:pokedex_id, :name, :level , :max_health_point, :current_health_point, :attack, :defence, :speed, :current_experience)
    end
end
