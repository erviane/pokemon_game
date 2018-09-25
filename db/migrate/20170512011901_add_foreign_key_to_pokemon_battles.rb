class AddForeignKeyToPokemonBattles < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :pokemon_battles, :pokemons, column: :pokemon1_id, on_delete: :cascade
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon2_id, on_delete: :cascade
  end
end
