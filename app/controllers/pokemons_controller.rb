class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy, :destroy_skill, :heal]
  before_action :select_pokedex, only: [:new, :create]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all.order("created_at ASC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokemons/1
  def show
    @pokemon_skills = PokemonSkill.new
    @number_of_win = PokemonBattle.where("pokemon_winner_id=?", @pokemon.id).count
    @number_of_lose = PokemonBattle.where("pokemon_loser_id=?", @pokemon.id).count
    @skill_list = Skill.all.collect {|p| [ p.name, p.id ] }
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
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
                                   :current_experience => 0, 
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
        redirect_to pokemon_url
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

  def heal
    pokemon1 = PokemonBattle.where(state: "ongoing").map{|x| x.pokemon1_id}
    pokemon2 = PokemonBattle.where(state: "ongoing").map{|x| x.pokemon2_id}
    ongoing_pokemon = pokemon1 + pokemon2
    if ongoing_pokemon.include?(params[:pokemon_id])
      flash[:danger] = "Heal failed. Pokemon is ongoing on battle"
    else
      @pokemon.update(current_health_point: @pokemon.max_health_point)
      @pokemon.pokemon_skills.each do |pokemon_skill|
        pokemon_skill.update(current_pp: pokemon_skill.skill_max_pp)
      end
      redirect_to :back
      flash[:success] = "Heal was Successfully"
    end
  end

  def heal_all
    pokemon1 = PokemonBattle.where(state: "ongoing").map{|x| x.pokemon1_id}
    pokemon2 = PokemonBattle.where(state: "ongoing").map{|x| x.pokemon2_id}
    ongoing_pokemon = pokemon1 + pokemon2
    Pokemon.all.each do |pokemon|
      if !ongoing_pokemon.include?(pokemon.id)
          pokemon.update(current_health_point: pokemon.max_health_point)
          pokemon.pokemon_skills.each do |pokemon_skill|
              pokemon_skill.update(current_pp: pokemon_skill.skill_max_pp)
          end
      end
    end
      redirect_to pokemons_url
      flash[:success] = "Heal All was Successfully"
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

    def select_pokedex
      @pokedex_select = Pokedex.all.map {|p| [ p.name, p.id ] }
    end
end
