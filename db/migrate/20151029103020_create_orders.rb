class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_status_id
      t.string :origin_order_number
      t.string :origin_payment_number
      t.string :customer_name
      t.string :phone
      t.string :id_number
      t.string :province
      t.string :city
      t.string :street
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
