class Product < ActiveRecord::Base
  belongs_to :product_catalog
  has_many :order_products  
end
