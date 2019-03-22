Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'team', to: 'home#team'
  get 'kitui', to: 'home#kitui'

  resources :products do
  	resources :comments
    resources :pictures, only: [:create, :destroy]
  end
  resources :wishlist_products
  resources :orders
  resources :charges
  resource :profile, only: [:show, :edit, :update]
  resource :children
  resources :categories, only: [:index]
  

  namespace :admin do
    root 'admin#index'
    resources :users, only: [:index, :show]
    resources :products, only: [:index, :show]
    resources :orders, only: [:index, :show, :update]
  end

  resources :conversations do
    resources :messages
  end


  get "/fetch_products" => 'products#from_category', as: 'fetch_products'
  get'payment_profile', to: 'stripeconnects#payment_profile'
  get "settings/payment-info/users/auth/stripe_connect/callback", to:"stripeconnects#stripe_callback"


end
