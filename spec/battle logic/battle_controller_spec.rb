require 'rails_helper'
require 'pry'

RSpec.describe PokemonBattlesController , :type => :controller do

  	before(:each) do
  		pokedex = Pokedex.create(	name: "pokedex", 
  									base_health_point: 10, 
  									base_attack: 10, 
  									base_defence: 10, 
  									base_speed: 10, 
  									element_type: "Normal", 
  									image_url: "http://abc.com"
  								) 
        @pokemon1 = Pokemon.create(	pokedex_id: pokedex.id, 
        							name: "Test", 
        							level: 1, 
        							max_health_point: 10, 
        							current_health_point: 10, 
        							attack: 10, 
        							defence: 10, 
        							speed: 10, 
        							current_experience: 1
        						)
        @pokemon2 = Pokemon.create(	pokedex_id: pokedex.id, 
        							name: "Test2", 
        							level: 1, 
        							max_health_point: 10, 
        							current_health_point: 10, 
        							attack: 10, 
        							defence: 10, 
        							speed: 10, 
        							current_experience: 1
        						)
        @skill1 = Skill.create(	name: "skill1", 
        						power: 10, 
        						max_pp: 10, 
        						element_type: "Normal"
        					)
        @skill2 = Skill.create(	name: "skill2", 
								power: 10, 
								max_pp: 10, 
								element_type: "Fire"
					)
		@pokemon_skill = PokemonSkill.create( 	skill_id: @skill1.id, 
												pokemon_id: @pokemon1.id, 
												current_pp: 10
											)
		@pokemon_skill2 = PokemonSkill.create( 	skill_id: @skill2.id, 
												pokemon_id: @pokemon2.id, 
												current_pp: 10
											)
		@pokemon_battle = PokemonBattle.create( pokemon1_id: @pokemon1.id, 
												pokemon2_id: @pokemon2.id, 
												current_turn:1, 
												state: "ongoing",
												pokemon1_max_health_point: @pokemon1.max_health_point, 
												pokemon2_max_health_point: @pokemon2.max_health_point
											)
  	end

  	it "if success" do
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon_skill: @pokemon_skill, pokemon: @pokemon1)
  		expect(battle.valid_next_turn?).to be true
  	end

  	it "failed attack if not pokemon's turn" do
  		@pokemon_battle.current_turn = 2
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon_skill: @pokemon_skill, pokemon: @pokemon1)
  		expect(battle.valid_next_turn?).to be false
  	end

  	it "failed attack if not pokemon's skill" do
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon_skill: @pokemon_skill2, pokemon: @pokemon1)
  		expect(battle.valid_next_turn?).to be false
  	end

  	it "failed attack if game has finished" do
  	  	@pokemon_battle.state = "finish"
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon_skill: @pokemon_skill, pokemon: @pokemon1)
  		expect(battle.valid_next_turn?).to be false
  	end

  	it "failed surrender if not pokemon's turn" do
  		@pokemon_battle.current_turn = 2
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon: @pokemon1)
  		expect(battle.valid_surrender?).to be false
  	end

  	it "failed surrender if game has finished" do
  	  	@pokemon_battle.state = "finish"
  		battle = BattleEngine.new(pokemon_battle: @pokemon_battle, pokemon: @pokemon1)
  		expect(battle.valid_surrender?).to be false
  	end
end
