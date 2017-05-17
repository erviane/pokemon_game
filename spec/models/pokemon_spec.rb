require 'rails_helper'
require 'pry'
RSpec.describe Pokemon, :type => :model do

    it "is valid with valid attributes" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to be_valid
    end 

    it "is not valid without a name" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: nil, level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid without apokedex id" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: nil, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid without a current health point" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: nil, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

    it "is not valid with a current health point less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: -1, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end  

    it "is not valid without a current experience" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: nil)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a current experience less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: -1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid without a max health point" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: nil, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a max health point less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: -1, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

    it "is not valid without a attack" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: nil, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a attack less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: -1, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

    it "is not valid without a defence" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: nil, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a defence less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: -1, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

    it "is not valid without a speed" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: nil, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a speed less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: 1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: -1, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

    it "is not valid without a level" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: nil, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end 

    it "is not valid with a level less than 0" do
        pokedex = Pokedex.create(name: "pokedex", base_health_point: 10, base_attack: 10, base_defence: 10, base_speed: 10, element_type: "Normal", image_url: "http://abc.com") 
        pokemon = Pokemon.create(pokedex_id: pokedex.id, name: "Test", level: -1, max_health_point: 10, current_health_point: 10, attack: 10, defence: 10, speed: 10, current_experience: 1)
        expect(pokemon).to_not be_valid
    end

end