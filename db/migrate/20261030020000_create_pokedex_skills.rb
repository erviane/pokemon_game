class CreatePokedexSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :pokedex_skills do |t|
      t.references :pokedex, null: false, foreign_key: { on_delete: :cascade }
      t.references :skill, null: false, foreign_key: { on_delete: :cascade }
      t.integer :learn_level, null: false, default: 1
      t.timestamps
    end
    add_index :pokedex_skills, [:pokedex_id, :skill_id], unique: true
  end
end
