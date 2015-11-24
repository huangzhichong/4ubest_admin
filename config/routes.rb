Rails.application.routes.draw do
  post 'orders/oo_unique', to: "orders#is_origin_order_number_valid?"
  post 'orders/op_unique', to: "orders#is_origin_payment_number_valid?"
  post 'orders/push_to_customs', to: "orders#push_to_customs"
  post 'orders/push_to_review', to: "orders#push_to_review"
  post 'orders/decline_order', to: "orders#decline_order"
  resources :orders
  resources :products
  root to: 'visitors#index'
  devise_for :users
  resources :users

  mount ChinaCity::Engine => '/china_city'
end
