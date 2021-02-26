Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints RoleRoutingConstraint.new :owner do
      # User Management
      get "/users", to: "admins#index", as: :list_users
      get "/users/new", to: "admins#new", as: :new_employee
      post "/users", to: "admins#create", as: :enroll_employee
      get "/users/:id", to: "admins#show", as: :edit_employee
      put "/users/:id", to: "admins#update", as: :update_employee
      delete "/users/:id", to:"admins#destroy", as: :destroy_employee
      # Orders view and management
      get "/orders", to: "orders_admin#index", as: :list_orders_admin
      get "/orders/:id", to: "orders_admin#show", as: :show_order_admin
      put "/orders/:id", to: "orders_admin#update", as: :mark_order_complete_admin
      delete "/orders/:id", to: "orders_admin#destroy", as: :delete_order_admin
      post "/orders/search", to: "orders_admin#search", as: :search_orders_admin

  end

  constraints RoleRoutingConstraint.new :billing_clerk do
      get "/orders", to: "orders_admin#index", as: :list_orders
      get "/orders/:id", to: "orders_admin#show", as: :show_order
      put "/orders/:id", to: "orders_admin#update", as: :mark_order_complete
      delete "/orders/:id", to: "orders_admin#destroy", as: :delete_order
      post "/orders/search", to: "orders_admin#search", as: :search_orders

      get "/walkin_order", to: "cart_items#index", as: :view_walkin_order, defaults: { order_type: "walkin" }
      get "/walkin_order/new", to: "cart_items#new", as: :new_walkin_item, defaults: { order_type: "walkin" }
      post "/walkin_order", to: "cart_items#create", as: :create_walkin_item, defaults: { order_type: "walkin" }
      put "/walkin_order", to: "cart_items#update", as: :modify_walkin_item, defaults: { order_type: "walkin" }
      delete "/walkin_order", to: "cart_items#destroy", as: :delete_walkin_item, defaults: { order_type: "walkin" }
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
  post "/orders/search", to: "orders#search"

  resources :order_items

  get "/", to: "home#index", as: :root

  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create", as: :login_auth
  delete "/logout", to: "sessions#destroy", as: :destroy_session
end
