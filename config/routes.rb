Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'kitui', to: 'home#kitui'
  resources :products
  resources :wishlist_products
  resource :profile, only: [:show, :edit, :update]
  resource :children

  get "/fetch_products" => 'products#from_category', as: 'fetch_products'
end
