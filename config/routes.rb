Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints RoleRoutingConstraint.new :owner do
      get "/users", to: "admins#index", as: :list_users
      get "/users/new", to: "admins#new", as: :new_employee
      post "/users", to: "admins#create", as: :enroll_employee
  end

  constraints RoleRoutingConstraint.new :billing_clerk do
      get "/orders", to: "orders_admin#index", as: :list_orders
      put "/orders/:id", to: "orders_admin#update", as: :mark_order_complete
      delete "/orders/:id", to: "orders_admin#destroy", as: :delete_order
  end

  resources :menus
  put "/menus/activate/:id", to: "menus#activate", as: :activate_menu

  resources :menu_items

  resources :items
  post "/items/select", to: "items#select", as: :select_items
  delete "/items/unselect/:id", to: "items#unselect", as: :unselect_item

  resources :users

  resources :cart_items

  resources :orders
  resources :order_items

  get "/", to: "home#index", as: :root

  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create", as: :login_auth
  delete "/logout", to: "sessions#destroy", as: :destroy_session
end
