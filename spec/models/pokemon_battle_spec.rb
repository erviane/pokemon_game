require 'rails_helper'
require 'pry'

RSpec.describe PokemonBattle, :type => :model do

    it "is valid with valid attributes" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn:1, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )
        expect(pokemon_battle).to be_valid
    end 

    it "is not valid without a pokemon1_id" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: nil, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn:1, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )
        expect(pokemon_battle).to_not be_valid
    end  

    it "is not valid without a pokemon2_id" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: nil, 
                                                current_turn:1, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )
        expect(pokemon_battle).to_not be_valid
    end 

    it "is not valid without a current_turn" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn: nil, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )
       expect(pokemon_battle).to_not be_valid
    end

    it "is not valid without a state" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn:1, 
                                                state: nil, 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )
        expect(pokemon_battle).to_not be_valid
    end

    it "is not valid without a pokemon1_max_health_point" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn:1, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: nil, 
                                                pokemon2_max_health_point: pokemon2.max_health_point
                                            )        
        expect(pokemon_battle).to_not be_valid
    end

    it "is not valid without a pokemon2_max_health_point" do
        pokedex = Pokedex.create(   name: "pokedex2", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        pokemon1 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon2 = Pokemon.create(  pokedex: pokedex, 
                                    name: "Test2", 
                                    level: 1, 
                                    max_health_point: 10, 
                                    current_health_point: 10, 
                                    attack: 10, 
                                    defence: 10, 
                                    speed: 10, 
                                    current_experience: 1
                                )
        pokemon_battle =PokemonBattle.create(   pokemon1_id: pokemon1.id, 
                                                pokemon2_id: pokemon2.id, 
                                                current_turn:1, 
                                                state: "ongoing", 
                                                pokemon_winner_id: pokemon1.id, 
                                                pokemon_loser_id: pokemon2.id, 
                                                experience_gain: 10, 
                                                pokemon1_max_health_point: pokemon1.max_health_point, 
                                                pokemon2_max_health_point: nil
                                            )
        expect(pokemon_battle).to_not be_valid
    end
end