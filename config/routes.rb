Rails.application.routes.draw do
  get 'orders/index'
  devise_for :users
  get '/contact', to: 'contact_pages#show'
  get '/about', to: 'about_pages#show'
  get '/products_list', to: 'products#products_list', as: 'products_list'
  get '/order_confirmation/:id', to: 'checkout#order_confirmation', as: 'order_confirmation'

  resources :products do
    get :products_list, on: :collection
  end

  resources :products do
    get :display_new_recently, on: :collection
  end

  resources :orders, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  # Root route
  root to: "home#index" # Assuming you have a HomeController with an index action

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Other routes
  resources :carts, only: [:index, :show, :create, :destroy, :update] do
    member do
      patch 'increase_quantity'
      patch 'decrease_quantity'
    end
  end

  # Example routes generated by Turbo
  get '/recede_historical_location', to: 'turbo/native/navigation#recede'
  get '/resume_historical_location', to: 'turbo/native/navigation#resume'
  get '/refresh_historical_location', to: 'turbo/native/navigation#refresh'

  # Routes for Action Mailbox (if used)
  namespace :rails do
    namespace :action_mailbox do
      post 'postmark/inbound_emails', to: 'postmark/inbound_emails#create'
      post 'relay/inbound_emails', to: 'relay/inbound_emails#create'
      post 'sendgrid/inbound_emails', to: 'sendgrid/inbound_emails#create'
      get 'mandrill/inbound_emails', to: 'mandrill/inbound_emails#health_check'
      post 'mandrill/inbound_emails', to: 'mandrill/inbound_emails#create'
      post 'mailgun/inbound_emails/mime', to: 'mailgun/inbound_emails#create'
      post 'products/:id/add_to_cart', to: 'products#add_to_cart', as: 'add_to_cart'
    end
  end
  post '/checkout/create_order', to: 'checkout#create_order', as: 'create_order_checkout'
  # Other routes for the application

  resources :categories
  resources :products, only: [:index, :show]
  resources :products
  resources :users
  resources :checkout, only: [:show, :create]

end
