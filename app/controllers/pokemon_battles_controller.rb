class PokemonBattlesController < ApplicationController
    before_action :set_pokemon_battle, only: [:show, :destroy, :attack] 

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
        @pokemon1_skills = @pokemon1.pokemon_skills.map {|p| [ "#{p.skill_name} (#{p.current_pp}/#{p.skill_max_pp})", p.id ] }
        @pokemon2_skills = @pokemon2.pokemon_skills.map {|p| [ "#{p.skill_name} (#{p.current_pp}/#{p.skill_max_pp})", p.id ] }
    end 

    # GET /pokemon_battles/new
    def new
       @pokemon_battle = PokemonBattle.new
       @pokemon_select = Pokemon.all.map {|p| [ p.name, p.id ] }
    end 

    # POST /pokemon_battles
    # POST /pokemon_battles.json
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
        pokemon_skill = PokemonSkill.find(params[:attack])
        pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
        pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
        current_turn = @pokemon_battle.current_turn
        current_pp = pokemon_skill.current_pp        
        if current_turn%2==1
            if current_pp == 0
                flash[:notice1] = "Current PP skill is empty. Try another skill"
                redirect_to :back
            end
            attacker = pokemon1
            defender = pokemon2
        else
            if current_pp == 0
                flash[:notice2] = "Current PP skill is empty. Try another skill"
                redirect_to :back
            end
            attacker = pokemon2
            defender = pokemon1
        end
        damage = PokemonBattleCalculator.calculate_damage(attacker, defender, pokemon_skill.skill)
        hp_defender = defender.current_health_point - damage.to_i
        current_pp -= 1
        current_turn += 1
        defender.update(current_health_point: hp_defender )
        pokemon_skill.update(current_pp: current_pp)
        @pokemon_battle.update(current_turn: current_turn)
        redirect_to :back
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
