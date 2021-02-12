Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints RoleRoutingConstraint.new :customer do
  end

  resources :menus
  resources :menu_items

  resources :items
  post "/items/select", to: "items#select", as: :select_items

  resources :users

  resources :cart_items

  resources :orders
  resources :order_items

  get "/", to: "home#index", as: :root

  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create", as: :login_auth
  delete "/logout", to: "sessions#destroy", as: :destroy_session


end
