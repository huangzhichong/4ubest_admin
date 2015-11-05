json.array!(@products) do |product|
  json.extract! product, :id, :name, :product_type_id, :model, :spec, :unit, :customs_code
  json.url product_url(product, format: :json)
end
