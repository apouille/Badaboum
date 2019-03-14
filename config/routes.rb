Rails.application.routes.draw do





  devise_for :users
  root "home#index"
  get 'kitui', to: 'home#kitui'
  resources :products
  resources :wishlist_products

  resources :orders
  resources :charges


  resource :profile, only: [:show, :edit, :update]
  resource :children


  get'payment_profile', to: 'stripeconnects#payment_profile'

  get "settings/payment-info/users/auth/stripe_connect/callback", to:"stripeconnects#stripe_callback"
end
