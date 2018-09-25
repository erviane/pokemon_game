class CreateTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :trainers do |t|
      t.string :name, null:false
      t.string :email, null:false
      t.string :password_digest, null:false

      t.timestamps null:false
    end
  end
end
