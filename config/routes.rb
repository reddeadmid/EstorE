Rails.application.routes.draw do
  get 'users/login'
  root "home#index"

  get '/products/:id/buy', to: 'products#buy', as: 'purchase'
  get '/cart', to: 'products#cart', as: 'cart'
  get '/checkout', to: 'products#checkout', as: 'checkout'

  get '/clearsession', to: 'application#clearsession', as: 'clearsession'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  resources :products, path: '/products'
end
