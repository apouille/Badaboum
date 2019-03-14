Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'kitui', to: 'home#kitui'
  
  resources :products do
  	resources :comments
  end

  resources :wishlist_products
  resource :profile, only: [:show, :edit, :update]
  resource :children

end
