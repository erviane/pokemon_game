class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy, :destroy_skill]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokemons/1
  def show
    @pokemon_skills = PokemonSkill.new
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
    @pokedex = Pokedex.all
  end

  # GET /pokemons/1/edit
  def edit
    @pokemon_skills = @pokemon.pokemon_skills
  end

  # POST /pokemons
  def create
      @pokemon = Pokemon.new(pokemon_params_create)
      if Pokedex.ids.include?params[:pokemon][:pokedex_id].to_i
        pokedex = Pokedex.find(params[:pokemon][:pokedex_id])
        @pokemon.assign_attributes({ :current_health_point => pokedex.base_health_point,
                                   :current_experience => 1, 
                                   :max_health_point => pokedex.base_health_point,
                                   :attack => pokedex.base_attack, 
                                   :defence => pokedex.base_defence, 
                                   :speed => pokedex.base_speed, 
                                   :level => 1 })
      end
    
      if @pokemon.save
        redirect_to pokemons_url
        flash[:success] = "New pokemon was successfully created" 
      else
        render :new
      end
  end

  # PATCH/PUT /pokemons/1
  def update
      if @pokemon.update(pokemon_params_edit)
        redirect_to pokemons_url
        flash[:success] = "Pokemon was successfully updated"
      else
        render :edit
      end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
      redirect_to pokemons_url
      flash[:success] = "Pokemon was successfully deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params_create
      params.require(:pokemon).permit(:pokedex_id, :name)
    end

    def pokemon_params_edit
      params.require(:pokemon).permit(:name, :max_health_point, :current_health_point, :attack, :defence, :speed, :current_experience)
    end
end
