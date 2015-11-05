class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :product_type_id
      t.string :model
      t.string :spec
      t.string :unit
      t.string :customs_code

      t.timestamps null: false
    end
  end
end
