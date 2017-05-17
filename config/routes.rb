Rails.application.routes.draw do

  resources :pokemon_battles
  resources :pokemons
  resources :skills
  resources :pokedexes

resources :pokemons do
	resources :pokemon_skills
end

resources :pokemon_battles do
	resources :pokemon_battle_logs
end

root 'pages#index'
delete '/pokemons/:pokemon_id/pokemon_skills/:skill_id', to: 'pokemon_skills#destroy', as: 'pokemon_skill_destroy'
post '/pokemon_battles/:id/pokemon_skills/', to: 'pokemon_battles#attack', as: 'attack'
get 'pokemon_battles/:id/surrender/:pokemon_id', to: 'pokemon_battles#surrender', as: 'surrender'
get 'heal/:id', to: 'pokemons#heal', as: 'heal'
get 'heal_all', to: 'pokemons#heal_all', as: 'heal_all'
end
