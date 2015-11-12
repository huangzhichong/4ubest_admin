class OrderProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order 
  validates_presence_of :product_id 
  def item_total_price
    self.number * self.custom_price
  end
  def item_total_tax_fee
    self.number * self.custom_price * self.product.product_catalog.tax_rate
  end
  def item_total_weight
    self.number * self.product.weight
  end
end
