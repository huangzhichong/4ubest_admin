Rails.application.routes.draw do
  resources :orders
  resources :products
  root to: 'visitors#index'
  devise_for :users
  resources :users

  mount ChinaCity::Engine => '/china_city'
end
