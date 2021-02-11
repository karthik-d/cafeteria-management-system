Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints RoleRoutingConstraint.new :customer do
      get "/", to: "sessions#new"

      get "/menus/:id", to: "active_menus#show", as: :active_menu
  end

  resources :menus

  resources :items
  post "/items/select", to: "items#select", as: :select_items

  resources :menu_items

  resources :users

  get "/", to: "home#index", as: :root

  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create", as: :login_auth
  delete "/logout", to: "sessions#destroy", as: :destroy_session


end
