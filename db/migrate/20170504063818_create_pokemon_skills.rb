class CreatePokemonSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_skills do |t|
      t.integer :skill_id, null:false
      t.integer :pokemon_id, null:false
      t.integer :current_pp

      t.timestamps null:false
    end
    add_index :pokemon_skills, :skill_id
    add_index :pokemon_skills, :pokemon_id
    add_foreign_key :pokemon_skills, :skills
    add_foreign_key :pokemon_skills, :pokemons
  end
end
