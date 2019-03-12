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

  get "/fetch_products" => 'products#from_category', as: 'fetch_products'
end
