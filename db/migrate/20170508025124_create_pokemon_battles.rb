class CreatePokemonBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battles do |t|
      t.integer :pokemon1_id, null:false
      t.integer :pokemon2_id, null:false
      t.integer :current_turn, null:false
      t.string :state, null:false
      t.integer :pokemon_winner_id
      t.integer :pokemon_loser_id
      t.integer :experience_gain
      t.integer :pokemon1_max_health_point, null:false
      t.integer :pokemon2_max_health_point, null:false

      t.timestamps null:false
    end
    add_index :pokemon_battles, :pokemon1_id
    add_index :pokemon_battles, :pokemon2_id
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon1_id
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon2_id
  end
end
