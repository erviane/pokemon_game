require 'rails_helper'

RSpec.describe Pokedex, :type => :model do
 

    it "is valid with valid attributes" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                ) 
        expect(pokedex).to be_valid
    end 

    it "is not valid without a name" do
        pokedex = Pokedex.create(   name: nil, 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid without a unique name" do
        pokedex1 = Pokedex.create(  name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        pokedex2 = Pokedex.create(  name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex2).to_not be_valid
    end

    it "is not valid without a base health_point" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: nil, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end 

    it "is not valid with a base health point less than 0" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: -1, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com")
        expect(pokedex).to_not be_valid
    end 

    it "is not valid without a base attack" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: nil, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid with a base attack less than 0" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: -1, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end 

    it "is not valid without a base defence" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: nil, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

     it "is not valid with a base defence less than 0" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: -1, 
                                    base_speed: 10, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid without a base speed" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: nil, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid with a base speed less than 0" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: -1, 
                                    element_type: "Normal", 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid without a element_type" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: nil, 
                                    image_url: "http://abc.com"
                                )
        expect(pokedex).to_not be_valid
    end

    it "is not valid if element type not include the list" do
        pokedex = Pokedex.create(   name: "Test1", 
                                    base_health_point: 10, 
                                    base_attack: 10, 
                                    base_defence: 10, 
                                    base_speed: 10, 
                                    element_type: "normal"
                                )
        expect(Skill::ELEMENT_TYPE).to_not include(pokedex)
    end
end