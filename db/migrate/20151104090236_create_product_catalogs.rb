class CreateProductCatalogs < ActiveRecord::Migration
  def change
    create_table :product_catalogs do |t|
      t.string :name
      t.string :catalog_number
      t.decimal :tax_rate

      t.timestamps null: false
    end
  end
end
