Rails.application.routes.draw do
  root "home#index"
  get "/products", to: "products#list"
  resources :products
end
