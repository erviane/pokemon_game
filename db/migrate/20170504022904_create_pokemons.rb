class CreatePokemons < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemons do |t|
      t.integer :pokedex_id, null:false
      t.string :name, null:false
      t.integer :level, null:false
      t.string :max_health_point, null:false
      t.integer :current_health_point, null:false
      t.integer :attack, null:false
      t.integer :defence, null:false
      t.integer :speed, null:false
      t.integer :current_experience, null:false

      t.timestamps null:false
    end
    add_index :pokemons, :pokedex_id
    add_foreign_key :pokemons, :pokedexes, on_delete: :cascade
  end
end