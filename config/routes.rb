Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'team', to: 'home#team'

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
    resources :users, only: [:index, :show, :destroy]
    resources :products, only: [:index, :show, :destroy]
    resources :orders, only: [:index, :show, :destroy]
  end
  

  get "/fetch_products" => 'products#from_category', as: 'fetch_products'
  get'payment_profile', to: 'stripeconnects#payment_profile'
  get "settings/payment-info/users/auth/stripe_connect/callback", to:"stripeconnects#stripe_callback"

end
