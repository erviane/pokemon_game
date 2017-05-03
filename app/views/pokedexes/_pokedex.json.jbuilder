json.extract! pokedex, :id, :name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url, :created_at, :updated_at
json.url pokedex_url(pokedex, format: :json)
