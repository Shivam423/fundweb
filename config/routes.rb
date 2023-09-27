Rails.application.routes.draw do

  # config/routes.rb
resources :charges, only: [:index]

  root "home#index"
  devise_for :users

  get "/index", to: "home#index"
  get "/about", to: "home#about"
  post "checkout/create", to: "charges#create"
  get '/success', to: 'charges#success', as: 'success_charges'
  get '/pay', to: "charges#pay"

  resources :products
  resources :cart_items, only: [:index, :create, :destroy] 
  resources :payments
    
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
