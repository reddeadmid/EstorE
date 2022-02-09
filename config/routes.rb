Rails.application.routes.draw do
  root "home#index"

  get "/products", to: "home#products"
end
