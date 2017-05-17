class CreatePokemonBattleLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battle_logs do |t|
      t.integer :pokemon_battle_id, null:false
      t.integer :turn, null:false
      t.integer :skill_id
      t.integer :damage
      t.integer :attacker_id, null:false
      t.integer :attacker_current_health_point, null:false
      t.integer :defender_id, null:false
      t.integer :defender_current_health_point, null:false
      t.string :action_type, null:false

      t.timestamps null:false
    end
    add_index :pokemon_battle_logs, :pokemon_battle_id
    add_index :pokemon_battle_logs, :skill_id
    add_foreign_key :pokemon_battle_logs, :pokemon_battles
    add_foreign_key :pokemon_battle_logs, :skills
 end
end
