class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  has_many :order_products

  accepts_nested_attributes_for :order_products,
    :allow_destroy => true,
    :reject_if     => :all_blank

  def shipping_address
    [self.province,self.city,self.street,self.zip_code].join
  end

  def total_price
    self.order_products.map{|t| t.custom_price * t.number}.sum
  end
end
