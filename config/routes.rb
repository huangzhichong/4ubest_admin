Rails.application.routes.draw do
  post 'orders/oo_unique', to: "orders#is_origin_order_number_valid?"
  post 'orders/op_unique', to: "orders#is_origin_payment_number_valid?"
  resources :orders
  resources :products
  root to: 'visitors#index'
  devise_for :users
  resources :users

  mount ChinaCity::Engine => '/china_city'
end
