class AddBattleTypeToPokemonBattles < ActiveRecord::Migration[5.0]
  def change
    add_column :pokemon_battles, :battle_type, :string
  end
end
