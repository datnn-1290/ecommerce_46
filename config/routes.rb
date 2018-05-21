Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: %i(index)
  resources :account_activations, only: %i(edit)
  resources :categories
  resources :products
  resources :order_details
  resources :carts
  resources :items
  resources :products, only: %i(index show) do
    resources :comments
    resources :ratings
  end
  namespace :admin do
    root "static_pages#home"
  end
end
