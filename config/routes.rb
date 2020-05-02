Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #welcome
  root "welcome#index"
  # get "/", to: "welcome#index"

  #merchants
  resources :merchants do 
    resources :items, only: [:index, :new, :create]
  end
  # get "/merchants", to: "merchants#index"
  # get "/merchants/new", to: "merchants#new"
  # get "/merchants/:id", to: "merchants#show"
  # post "/merchants", to: "merchants#create"
  # get "/merchants/:id/edit", to: "merchants#edit"
  # patch "/merchants/:id", to: "merchants#update"
  # delete "/merchants/:id", to: "merchants#destroy"

  #items
  resources :items, only: [:index, :show, :edit, :update, :destroy] do 
    resources :reviews, only: [:new, :create]
  end
  # get "/items", to: "items#index"
  # get "/items/:id", to: "items#show"
  # get "/items/:id/edit", to: "items#edit"
  # patch "/items/:id", to: "items#update"
  # delete "/items/:id", to: "items#destroy"
  # get "/merchants/:merchant_id/items", to: "items#index"
  # get "/merchants/:merchant_id/items/new", to: "items#new"
  # post "/merchants/:merchant_id/items", to: "items#create"

  #reviews
  resources :reviews, only: [:edit, :update, :destroy]
  # get "/reviews/:id/edit", to: "reviews#edit"
  # patch "/reviews/:id", to: "reviews#update"d
  # delete "/reviews/:id", to: "reviews#destroy"
  # get "/items/:item_id/reviews/new", to: "reviews#new"
  # post "/items/:item_id/reviews", to: "reviews#create"

  #cart
  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/increase/:item_id",  to: "cart#increase_quantity"
  patch "/cart/decrease/:item_id",  to: "cart#decrease_quantity"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  #orders
  resources :orders, only: [:new, :create, :show]
  # get "/orders/new", to: "orders#new"
  # post "/orders", to: "orders#create"
  # get "/orders/:id", to: "orders#show"

  #sessions
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  #users
  get "/register", to: "users#new"
  post "/users", to: "users#create"
  get "/profile", to: "users#show"
  get '/profile/password/edit', to: 'users_password#edit'
  patch '/profile/password', to: 'users_password#update'
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/orders", to: "orders#index"
  get "/profile/orders/:id", to: 'orders#show'
  patch "/profile/orders/:id", to: "item_orders#update"

  #merchant
  namespace :merchant do
    get '/dashboard', to: 'dashboard#show'
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    # get '/items', to: 'items#index'
    # patch '/items/:id', to: 'items#update'
    # delete '/items/:id', to: 'items#destroy'
    # get '/items/new', to: 'items#new'
    # post '/items', to: 'items#create'
    # get 'items/:id/edit', to: 'items#edit'
    resources :orders, only: [:show]
    # get '/orders/:id', to: 'orders#show'
    resources :item_orders, only: [:update]
    # patch '/item_orders/:id', to: 'item_orders#update'
  end

  #admin
  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :users, only: [:index, :show, :edit, :update] do 
      get 'password/edit', to: 'users_password#edit'
      patch '/password/edit', to: 'users_password#update'
      get '/orders', to: 'users_orders#index'
    end
    # get '/users', to: 'users#index'
    # get "/users/:user_id", to: "users#show"
    # get '/users/:user_id/edit', to: 'users#edit'
    # patch '/users/:user_id', to: 'users#update'
    resources :items
    resources :orders, only: [:update]
    resources :merchants do
      resources :items, only: [:index, :edit, :update], controller: 'merchant_items'
      # get '/items', to: 'merchant_items#index'
      # get '/items/:item_id/edit', to: 'merchant_items#edit'
      # patch '/items/:item_id', to: 'merchant_items#update'
    end
  end

end
