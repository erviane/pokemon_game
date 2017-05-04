Rails.application.routes.draw do

  resources :pokemons
  resources :skills
  resources :pokedexes
root 'pages#index'
end
