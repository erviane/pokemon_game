class RemoveTrainers < ActiveRecord::Migration[8.1]
  def change
    remove_reference :pokemons, :trainer, type: :integer, index: true, foreign_key: { on_delete: :cascade }

    drop_table :trainers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
