require "rexml/document"
include REXML

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  has_many :order_products
  before_save :default_values

  validates :order_status_id, presence: true
  validates :origin_order_number, presence: true
  validates :origin_payment_number, presence: true
  validates :customer_name, presence: true
  validates :phone, presence: true
  validates :id_number, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :zip_code, presence: true
  validates :area, presence: true
  validates :shipping_fee, presence: true

  validates_associated :order_products
  accepts_nested_attributes_for :order_products,
    :allow_destroy => true,
    :reject_if     => :all_blank

  def shipping_address
    [self.province,self.city,self.area,self.street].join
  end

  def total_price
    self.order_products.map{|t| t.item_total_price}.sum
  end
  def total_tax_fee
    self.order_products.map{|t| t.item_total_tax_fee}.sum
  end
  def total_weight
    self.order_products.map{|t| t.item_total_weight}.sum
  end
  def default_values
    self.order_status_id ||= OrderStatus.find_by_status("未提交").id
  end
end
