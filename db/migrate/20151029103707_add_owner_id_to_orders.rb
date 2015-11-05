class AddOwnerIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :owner_id, :integer
  end
end
