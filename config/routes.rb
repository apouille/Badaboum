Rails.application.routes.draw do



  devise_for :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'kitui', to: 'home#kitui'

  resources :products

  
  resources :wishlist_products
  

  resource :profile, only: [:show, :edit, :update] 

  get'payment_profile', to: 'stripeconnects#payment_profile'

  get "settings/payment-info/users/auth/stripe_connect/callback", to:"stripeconnects#stripe_callback"
end
