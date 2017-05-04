json.extract! pokemon, :id, :pokedex_id, :name, :level, :max_health_point, :integer, :current_health_point, :attack, :defence, :speed, :current_experience, :created_at, :updated_at
json.url pokemon_url(pokemon, format: :json)
