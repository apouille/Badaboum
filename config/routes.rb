Rails.application.routes.draw do

  devise_for :users
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'kitui', to: 'home#kitui'
end
