Rails.application.routes.draw do

<<<<<<< HEAD

  get 'products/index'
  get 'products/show'
  get 'products/create'
  get 'products/new'
  get 'products/update'
  get 'products/destroy'
  devise_for :users 
=======
  devise_for :users
>>>>>>> delivery


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'kitui', to: 'home#kitui'
  get 'profile', to: 'home#profile'

  resources :products
<<<<<<< HEAD
  
  resources :wishlist_products
  
=======
  resource :profile, only: [:show, :edit, :update]

>>>>>>> delivery

end
