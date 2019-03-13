Rails.application.routes.draw do


  get 'products/index'
  get 'products/show'
  get 'products/create'
  get 'products/new'
  get 'products/update'
  get 'products/destroy'
  devise_for :users 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'kitui', to: 'home#kitui'

  resources :products
  
  resources :wishlist_products
  

end
