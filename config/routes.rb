Rails.application.routes.draw do
  root "home#index"
  get '/products/:id/buy', to: 'products#buy', as: 'purchase'
  get '/cart', to: 'products#cart', as: 'cart'
  get '/checkout', to: 'products#checkout', as: 'checkout'

  resources :products, path: '/products'
end
