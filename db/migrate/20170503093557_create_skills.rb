class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :name, null:false
      t.integer :power, null:false
      t.integer :max_pp, null:false
      t.string :element_type, null:false

      t.timestamps null:false
    end
  end
end
