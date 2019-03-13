Rails.application.routes.draw do

  devise_for :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'kitui', to: 'home#kitui'
  get 'profile', to: 'home#profile'

  resources :products
  resource :profile, only: [:show, :edit, :update]


end
