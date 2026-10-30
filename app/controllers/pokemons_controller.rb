class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy, :destroy_skill, :heal]
  before_action :select_pokedex, only: [:new, :create]

  # GET /pokemons
  def index
      @pokemons = Pokemon.search(params[:q]).of_type(params[:type]).includes(:pokedex).order("pokemons.created_at ASC").paginate(page: params[:page], per_page: 20)
  end

  # GET /pokemons/1
  def show
      @skill_rows = @pokemon.pokemon_skills.joins(:skill).includes(:skill)
                            .sorted(params[:sort], params[:dir], PokemonSkill::SORTS, default: "pokemon_skills.created_at ASC")
      @number_of_win = PokemonBattle.where("pokemon_winner_id=?", @pokemon.id).count
      @number_of_lose = PokemonBattle.where("pokemon_loser_id=?", @pokemon.id).count
      @skill_list = @pokemon.learnable_skills.where.not(id: @pokemon.skill_ids).order(:name).collect {|p| [ t("pokemons.skill_option", name: p.name, type: p.element_type, power: p.power), p.id ] }
      locked = @pokemon.pokedex.pokedex_skills.includes(:skill).where("learn_level > ?", @pokemon.level).order(:learn_level)
      @skill_list += locked.map {|p| [ t("pokemons.skill_option_locked", name: p.skill.name, level: p.learn_level), p.skill_id, { disabled: true } ] }
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
      assign_attribute         

      if @pokemon.save
          redirect_to pokemon_url(@pokemon)
          flash[:success] = t("flash.pokemons.created", name: @pokemon.name)
      else
          render :new, status: :unprocessable_entity
      end 
  end

  # PATCH/PUT /pokemons/1
  def update
      if @pokemon.update(pokemon_params_edit)
          redirect_to pokemon_url(@pokemon)
          flash[:success] = t("flash.pokemons.updated", name: @pokemon.name)
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
      redirect_to pokemons_url
      flash[:success] = t("flash.pokemons.released", name: @pokemon.name)
  end

  def heal
    if PokemonBattle.ongoing_pokemon_ids.include?(@pokemon.id)
      flash[:danger] = t("flash.pokemons.in_battle", name: @pokemon.name)
    else
      @pokemon.update(current_health_point: @pokemon.max_health_point)
      @pokemon.pokemon_skills.each do |pokemon_skill|
        pokemon_skill.update(current_pp: pokemon_skill.skill_max_pp)
      end
      flash[:success] = t("flash.pokemons.healed", name: @pokemon.name)
    end
    redirect_back fallback_location: pokemon_path(@pokemon)
  end

  def heal_all
    ongoing_pokemon = PokemonBattle.ongoing_pokemon_ids
    @pokemon = Pokemon.all
    @pokemon.each do |pokemon|
      if !ongoing_pokemon.include?(pokemon.id)
          pokemon.update(current_health_point: pokemon.max_health_point)
          pokemon.pokemon_skills.first(3).each do |pokemon_skill|
              pokemon_skill.update(current_pp: pokemon_skill.skill_max_pp)
          end
      end
    end
      skipped = @pokemon.count { |pokemon| ongoing_pokemon.include?(pokemon.id) }
      flash[:success] = skipped > 0 ? t("flash.pokemons.healed_all_except", count: skipped) : t("flash.pokemons.healed_all")
      redirect_back fallback_location: root_path
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
      @pokedex_select = Pokedex.order(:name).map {|p| [ p.name.capitalize, p.id ] }
    end

    def assign_attribute
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
    end
end
