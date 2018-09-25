require 'rails_helper'
require 'pry'

RSpec.describe BattleEngine do

    before(:each) do
      pokedex = Pokedex.create( name: "pokedex", 
                                base_health_point: 10, 
                                base_attack: 10, 
                                base_defence: 10, 
                                base_speed: 10, 
                                element_type: "Normal", 
                                image_url: "http://abc.com"
                              ) 
        @pokemon1 = Pokemon.create( pokedex_id: pokedex.id, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                  )
        @pokemon2 = Pokemon.create( pokedex_id: pokedex.id, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                  )
        @skill1 = Skill.create( name: "skill1", 
                                  power: 10, 
                                  max_pp: 10, 
                                  element_type: "Normal"
                                )
        @skill2 = Skill.create( name: "skill2", 
                                power: 10, 
                                max_pp: 10, 
                                element_type: "Fire"
                              )
        @pokemon_skill = PokemonSkill.create(   skill_id: @skill1.id, 
                                                pokemon_id: @pokemon1.id, 
                                                current_pp: 10
                                              )
        @pokemon_skill2 = PokemonSkill.create(  skill_id: @skill2.id, 
                                                pokemon_id: @pokemon2.id, 
                                                current_pp: 10
                                              )
        @pokemon_battle = PokemonBattle.create( pokemon1_id: @pokemon1.id, 
                                                pokemon2_id: @pokemon2.id, 
                                                current_turn:1, 
                                                state: "ongoing",
                                                pokemon1_max_health_point: @pokemon1.max_health_point, 
                                                pokemon2_max_health_point: @pokemon2.max_health_point,
                                                battle_type: "Manual Battle"
                                              )
    end

    it "if manual battle success attack" do
      battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                  pokemon_skill: @pokemon_skill, 
                                  pokemon: @pokemon1)
      expect(battle.valid_next_turn?).to be true
      battle.attack
      pokemon_battle_logs = @pokemon_battle.pokemon_battle_logs
      expect(@pokemon_battle.current_turn).to eq(2)
      expect(pokemon_battle_logs.count).to eq(1)
      battle.player
      expect(battle.attacker).to eq(@pokemon2)
    end

    it "failed attack if not pokemon's turn" do
      @pokemon_battle.current_turn = 2
      battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                  pokemon_skill: @pokemon_skill, 
                                  pokemon: @pokemon1
                                )
      expect(battle.valid_next_turn?).to be false
      expect(@pokemon_battle.current_turn).to eq (2)
      expect(battle.attacker). to eq(@pokemon2)
    end

    it "failed attack if not pokemon's skill" do
      battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                  pokemon_skill: @pokemon_skill2, 
                                  pokemon: @pokemon1
                                )
      expect(battle.valid_next_turn?).to be false
      expect(@pokemon_battle.current_turn).to eq (1)
      expect(battle.attacker). to eq(@pokemon1)
    end

    it "failed attack if game has finished" do
      @pokemon_battle.state = "finish"
      battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                  pokemon_skill: @pokemon_skill, 
                                  pokemon: @pokemon1
                                )
      expect(battle.valid_next_turn?).to be false
    end

    it "if success surrender" do
      battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                  pokemon: @pokemon1
                                )
      expect(battle.valid_surrender?).to be true
      battle.surrender
      expect(@pokemon_battle.state).to eq "finish"
      expect(@pokemon_battle.pokemon_winner_id).to_not be_nil
      expect(@pokemon_battle.pokemon_loser_id).to_not be_nil
      expect(@pokemon_battle.experience_gain).to_not be_nil
    end

    it "failed surrender if not pokemon's turn" do
      @pokemon_battle.current_turn = 2
      battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon: @pokemon1)
      expect(battle.valid_surrender?).to be false
      expect(@pokemon_battle.current_turn).to eq(2)
      expect(battle.attacker).to eq(@pokemon2)
    end

    it "failed surrender if game has finished" do
        @pokemon_battle.state = "finish"
      battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon: @pokemon1)
      expect(battle.valid_surrender?).to be false
    end

    it "run auto battle success" do
        @pokemon_battle.update(battle_type: "Auto Battle")
        battle = BattleEngine.new(pokemon_battle: @pokemon_battle)
        battle.auto_battle
        expect(@pokemon_battle.state).to eq "finish"
        expect(@pokemon_battle.pokemon_winner_id).to_not be_nil
        expect(@pokemon_battle.pokemon_loser_id).to_not be_nil
        expect(@pokemon_battle.experience_gain).to_not be_nil
    end


    it "run auto battle surrender" do
        @pokemon_battle.update(battle_type: "Auto Battle")
        @pokemon_skill.update(current_pp: 0)
        battle = BattleEngine.new(pokemon_battle: @pokemon_battle)
        battle.auto_battle
        last_battle_log = @pokemon_battle.pokemon_battle_logs.last
        expect(@pokemon_battle.state).to eq "finish"
        expect(@pokemon_battle.pokemon_winner_id).to_not be_nil
        expect(@pokemon_battle.pokemon_loser_id).to_not be_nil
        expect(@pokemon_battle.experience_gain).to_not be_nil
        expect(last_battle_log.action_type).to eq "surrender"
    end

    it "run vs AI success" do
        @pokemon_battle.update(battle_type: "Player VS AI")
        battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                    pokemon_skill: @pokemon_skill, 
                                    pokemon: @pokemon1
                                  )
        battle.player
        battle.attack
        pokemon_battle_logs = @pokemon_battle.pokemon_battle_logs
        expect(@pokemon_battle.current_turn).to eq(3)
        expect(pokemon_battle_logs.count).to eq(2)
    end

    it "run vs AI surrender" do
        @pokemon_battle.update(battle_type: "Player VS AI")
        @pokemon_skill2.update(current_pp: 0)
        battle = BattleEngine.new(  pokemon_battle: @pokemon_battle, 
                                    pokemon_skill: @pokemon_skill, 
                                    pokemon: @pokemon1
                                  )
        battle.player
        battle.attack
        last_battle_log = @pokemon_battle.pokemon_battle_logs.last
        expect(@pokemon_battle.current_turn).to eq(2)
        expect(@pokemon_battle.state).to eq "finish"
        expect(@pokemon_battle.pokemon_winner_id).to_not be_nil
        expect(@pokemon_battle.pokemon_loser_id).to_not be_nil
        expect(@pokemon_battle.experience_gain).to_not be_nil
        expect(last_battle_log.action_type).to eq "surrender"
    end
end
