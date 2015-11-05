class ChangeOwnerIdToUserIdInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :owner_id, :user_id
  end
end
