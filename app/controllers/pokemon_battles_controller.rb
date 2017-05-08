class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :destroy]

  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index
    @pokemon_battles = PokemonBattle.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokemon_battles/1
  # GET /pokemon_battles/1.json
  def show
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
  end

  # GET /pokemon_battles/new
  def new
    @pokemon_battle = PokemonBattle.new
  end

  # POST /pokemon_battles
  # POST /pokemon_battles.json
  def create
    @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
    current_turn = 1
    state = "ongoing"
    pokemon1 = Pokemon.find(params[:pokemon1_id])
    pokemon2 = Pokemon.find(params[:pokemon2_id])
    pokemon1_max_health_point = pokemon1.max_health_point
    pokemon2_max_health_point = pokemon2.max_health_point
    @pokemon_battle.assign_attributes({:current_turn => current_turn,
                                      :state => state,
                                      :pokemon1_max_health_point => pokemon1_max_health_point,
                                      :pokemon2_max_health_point => pokemon2_max_health_point})
      if @pokemon_battle.save
        redirect_to pokemon_battle_url(@pokemon_battle)
      else
        render :new
      end
  end

  # DELETE /pokemon_battles/1
  # DELETE /pokemon_battles/1.json
  def destroy
    @pokemon_battle.destroy
    redirect_to pokemon_battles_url
    flash[:success] = "Pokemon battle was successfully destroyed"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle
      @pokemon_battle = PokemonBattle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_params
      params.permit(:pokemon1_id, :pokemon2_id)
    end
end
