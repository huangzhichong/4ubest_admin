json.array!(@orders) do |order|
  json.extract! order, :id, :order_status_id, :origin_order_number, :origin_payment_number, :customer_name, :phone, :id_number, :province, :city, :street, :zip_code
  json.url order_url(order, format: :json)
end
