require 'pry'

class BattleEngine
	attr_accessor :flash
    attr_accessor :pokemon_battle
    attr_accessor :attacker_skill
    attr_accessor :pokemon
    attr_reader :damage
    attr_reader :attacker
    attr_reader :defender

	def initialize(pokemon_battle:, pokemon_skill:nil, pokemon:nil)
		@pokemon_battle = pokemon_battle
		@attacker_skill = pokemon_skill
        @pokemon = pokemon
		@flash = {}
	end

    def valid_next_turn?
        player
        @pokemon_battle.state == "ongoing" &&
        @attacker.id == @pokemon.id &&
        (@pokemon.pokemon_skills.include?attacker_skill)
    end  

    def valid_surrender?
       player
       @pokemon_battle.state == "ongoing" &&
       @attacker.id == @pokemon.id
    end

	def next_turn!
	    @current_turn += 1
	    @pokemon_battle.update(current_turn: @current_turn)
	end

	def attack
        @damage = PokemonBattleCalculator.calculate_damage(@attacker, @defender, @attacker_skill.skill)
        @hp_defender = @defender.current_health_point - damage.to_i
        @hp_defender = 0 if @hp_defender < 0
        attacker_current_pp = @attacker_skill.current_pp - 1
        @attacker_skill.update(current_pp: attacker_current_pp)
        attack_success = @defender.update(current_health_point: @hp_defender)
        
        if @hp_defender == 0
           result(@attacker, @defender)
        end
        PokemonBattleLog.create(pokemon_battle_id: @pokemon_battle.id,
                                turn: @pokemon_battle.current_turn,
                                skill_id: @attacker_skill.skill.id,
                                damage: @damage,
                                attacker_id: @attacker.id,
                                attacker_current_health_point: @attacker.current_health_point,
                                defender_id: @defender.id,
                                defender_current_health_point: @hp_defender,
                                action_type: "attack")
        next_turn!
        if (@pokemon_battle.battle_type == "Player VS AI") && (@pokemon_battle.current_turn%2 == 0) && (@pokemon_battle.state == "ongoing")
            ai_do_attack
        end     
	end

    def ai_do_attack
        player 
        pokemon_ai_skill = @attacker.pokemon_skills.where("current_pp>?", 0)
        if !pokemon_ai_skill.empty?
            @attacker_skill = pokemon_ai_skill.sample
            attack
            sleep 1
        else
            surrender
        end 
    end

    def auto_battle
        while @pokemon_battle.state == "ongoing"
        player
        @attacker_skill_all = @attacker.pokemon_skills.where("current_pp>?", 0)
        if !@attacker_skill_all.empty?
            @attacker_skill = @attacker_skill_all.sample
            attack
        else
            surrender
        end
    end
    end 

	def surrender
		player
		result(@defender, @attacker)
        PokemonBattleLog.create(pokemon_battle_id: @pokemon_battle.id,
                     turn: @pokemon_battle.current_turn,
                     attacker_id: @attacker.id,
                     attacker_current_health_point: @attacker.current_health_point,
                     defender_id: @defender.id,
                     defender_current_health_point: @defender.current_health_point,
                     action_type: "surrender")
	end

    def player
        pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
        pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
        @current_turn = @pokemon_battle.current_turn         
        if @current_turn%2==1
            @attacker = pokemon1
            @defender = pokemon2
        else
            @attacker = pokemon2
            @defender = pokemon1
        end 
    end

    private

    def result(winner, loser)
    	experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
     	save!(@pokemon_battle, winner, loser, experience_gain)                
        if PokemonBattleCalculator.level_up?(winner.level, winner.current_experience)
            winner_level_up(winner)
        end
    end

    def save!(pokemon_battle, winner, loser, experience_gain)
		    pokemon_battle.update(state: "finish", 
                                pokemon_winner_id: winner.id, 
                                pokemon_loser_id: loser.id,
                                experience_gain: experience_gain)
        winner_experience = winner.current_experience + experience_gain
        winner.update(current_experience: winner_experience)		
	 end

    def save_extra_point(winner, extra_point)
    	winner_max_hp = winner.max_health_point.to_i + extra_point[:health]
        winner_attack = winner.attack + extra_point[:attack]
        winner_defence = winner.defence + extra_point[:defence]
        winner_speed = winner.speed + extra_point[:speed]
        winner.update( max_health_point: winner_max_hp,
                      attack: winner_attack, 
                      defence: winner_defence, 
                      speed: winner_speed)
    end

    def winner_level_up(winner)
    	level_up(winner)
        extra_point = PokemonBattleCalculator.calculate_level_up_extra_stats
        save_extra_point(winner, extra_point)
        @flash[:success] = "#{winner.name} level up"
    end

    def level_up(winner)
	    level_pass =  Math.log((winner.current_experience/100),2).to_i
	    level_now = level_pass + 1
	    winner.update(level: level_now)
    end
end