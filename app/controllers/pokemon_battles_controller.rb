class PokemonBattlesController < ApplicationController
    before_action :set_pokemon_battle, only: [:show, :destroy, :attack, :surrender]
#    before_action :turn, only: [:attack, :surrender]

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
        pokemon1_select_skill =  @pokemon1.pokemon_skills.where("current_pp >?", 0)
        pokemon2_select_skill =  @pokemon2.pokemon_skills.where("current_pp >?", 0)
        @pokemon1_skills = pokemon1_select_skill.map {|p| [ "#{p.skill_name} (#{p.current_pp}/#{p.skill_max_pp})", p.id ] }
        @pokemon2_skills = pokemon2_select_skill.map {|p| [ "#{p.skill_name} (#{p.current_pp}/#{p.skill_max_pp})", p.id ] }
        
    end 

    # GET /pokemon_battles/new
    def new
       @pokemon_battle = PokemonBattle.new
       select_pokemon
    end 

    # POST /pokemon_battles
    def create
        @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
        if  (Pokemon.ids.include?params[:pokemon1_id].to_i) && (Pokemon.ids.include?params[:pokemon2_id].to_i)
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
        end
        if @pokemon_battle.save
            redirect_to pokemon_battle_url(@pokemon_battle)
        else
            select_pokemon
            render :new
        end 

    end 

    # DELETE /pokemon_battles/1
    def destroy
        @pokemon_battle.destroy
        redirect_to pokemon_battles_url
        flash[:success] = "Pokemon battle was successfully destroyed"
    end 

    def attack
        attacker_skill = PokemonSkill.find(params[:attack])
        battle = BattleEngine.new(pokemon_battle: @pokemon_battle, skill: attacker_skill)        
        battle.attack        
        flash[:success] = battle.flash[:success]
        if battle.valid_next_turn?            
            battle.next_turn!
        else
            flash[:danger] = "Failed attack. Try again"
        end
        redirect_to :back
    end 


    def surrender
        battle = BattleEngine.new(pokemon_battle: @pokemon_battle)
        battle.surrender
        flash[:success] = battle.flash[:success]
        redirect_to :back        
    end

    private

    def set_pokemon_battle
        @pokemon_battle = PokemonBattle.find(params[:id])
    end     

    def pokemon_battle_params
          params.permit(:pokemon1_id, :pokemon2_id)
    end   


    def select_pokemon
        available_pokemon = Pokemon.where("current_health_point>?",0)
        @pokemon_select = available_pokemon.all.collect {|p| [ p.name, p.id ] }
    end

end
