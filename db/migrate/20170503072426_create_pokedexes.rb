class CreatePokedexes < ActiveRecord::Migration[5.0]
  def change
    create_table :pokedexes do |t|
      t.string :name, null:false
      t.integer :base_health_point, null:false
      t.integer :base_attack, null:false
      t.integer :base_defence, null:false
      t.integer :base_speed, null:false
      t.string :element_type, null:false
      t.string :image_url, null:false

      t.timestamps null:false
    end
  end
end
