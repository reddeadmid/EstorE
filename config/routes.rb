Rails.application.routes.draw do
  root "home#index"

  get "/list", to: "home#list"
end
