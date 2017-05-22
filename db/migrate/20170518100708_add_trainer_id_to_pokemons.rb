class AddTrainerIdToPokemons < ActiveRecord::Migration[5.0]
  def change
    add_column :pokemons, :trainer_id, :integer
    add_index :pokemons, :trainer_id
    add_foreign_key :pokemons, :trainers, on_delete: :cascade
  end
end
