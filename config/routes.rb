Rails.application.routes.draw do

  resources :pokemon_battles
  resources :pokemons
  resources :skills
  resources :pokedexes

resources :pokemons do
	resources :pokemon_skills
end

root 'pages#index'
delete '/pokemons/:pokemon_id/pokemon_skills/:skill_id', to: 'pokemon_skills#destroy', as: 'pokemon_skill_destroy'
post '/pokemon_battles/:id/pokemon_skills/', to: 'pokemon_battles#attack', as: 'attack'
end
