class AddAreaAndShippingFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :area, :string
    add_column :orders, :shipping_fee, :decimal
  end
end
