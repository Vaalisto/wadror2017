Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs
  resources :memberships
  resources :users
  resources :beers  
  resource :session, only: [:new, :create, :destroy]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'

  delete 'signout', to: 'sessions#destroy'

  post 'places', to:'places#search'
 
end
