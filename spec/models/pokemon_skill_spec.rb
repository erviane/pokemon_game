require 'rails_helper'
require 'pry'

RSpec.describe PokemonSkill, :type => :model do

    it "is valid with valid attributes" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        pokedex = Pokedex.create(name: "pokedex2", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex: pokedex, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        pokemon_skill = PokemonSkill.create(skill_id: skill.id, pokemon_id: pokemon.id, current_pp: 10)
        expect(pokemon_skill).to be_valid
    end 

    it "is not valid without a skill_id" do
        skill = Skill.create(name: "Test2", 
                            power: 10, 
                            max_pp: 10, 
                            element_type: "Normal")
        pokedex = Pokedex.create(name: "pokedex", 
                                base_health_point: 10, 
                                base_attack: 10, 
                                base_defence: 10, 
                                base_speed: 10, 
                                element_type: "Normal", 
                                image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex: pokedex, 
                                name: "Test", 
                                level: 1, 
                                max_health_point: 10, 
                                current_health_point: 10, 
                                attack: 10, 
                                defence: 10, 
                                speed: 10, 
                                current_experience: 1)
        pokemon_skill = PokemonSkill.new(skill_id: nil, pokemon_id: pokemon.id, current_pp: 10)
        expect{pokemon_skill.valid?}.to raise_error
    end  

    it "is not valid without a pokemon_id" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex: pokedex, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        pokemon_skill = PokemonSkill.create(skill_id: skill.id, pokemon_id: nil, current_pp: 10)
        expect(pokemon_skill).to_not be_valid
    end 

    it "is not valid without a current_pp" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex: pokedex, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        pokemon_skill = PokemonSkill.create(skill_id: skill.id, pokemon_id: pokemon.id, current_pp: nil)     
        expect(pokemon_skill).to_not be_valid
    end

    it "is not valid with a current_pp less than 0" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex: pokedex, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        pokemon_skill = PokemonSkill.create(skill_id: skill.id, pokemon_id: pokemon.id, current_pp: -1)
        expect(pokemon_skill).to_not be_valid
    end
end