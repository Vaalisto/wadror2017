Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs  
  resources :beers  
  resource :session, only: [:new, :create, :destroy]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_ban', on: :member
  end

  resources :memberships do
    post 'accept_membership', on: :member
  end

  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'  
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
  get 'auth/:provider/callback', to: 'sessions#create_oauth'

  delete 'signout', to: 'sessions#destroy'

  post 'places', to:'places#search'

end
