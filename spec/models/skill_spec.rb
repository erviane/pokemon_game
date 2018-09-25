require 'rails_helper'

RSpec.describe Skill, :type => :model do

    it "is valid with valid attributes" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        expect(skill).to be_valid
    end 

    it "is not valid without a name" do
        skill = Skill.create(name: nil, power: 10, max_pp: 10, element_type: "Normal")
        expect(skill).to_not be_valid
    end

    it "is not valid without unique name" do
        skill1 = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        skill2 = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "Normal")
        expect(skill2).to_not be_valid
    end 

    it "is not valid without a power" do
        skill = Skill.create(name: "Test2", power: nil, max_pp: 10, element_type: "Normal")
        expect(skill).to_not be_valid
    end

    it "is not valid with a power less than 0" do
        skill = Skill.create(name: "Test2", power: -1, max_pp: 10, element_type: "Normal")
        expect(skill).to_not be_valid
    end  

    it "is not valid without a max PP" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: nil, element_type: "Normal")
        expect(skill).to_not be_valid
    end 

    it "is not valid with a max PP less than 0" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: -1, element_type: "Normal")
        expect(skill).to_not be_valid
    end 

    it "is not valid without a element_type" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: nil)
        expect(skill).to_not be_valid
    end

    it "is not valid if element type not include the list" do
        skill = Skill.create(name: "Test2", power: 10, max_pp: 10, element_type: "normal")
        expect(Skill::ELEMENT_TYPE).to_not include(skill)
    end
end