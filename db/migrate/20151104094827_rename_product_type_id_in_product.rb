class RenameProductTypeIdInProduct < ActiveRecord::Migration
  def change
    rename_column :products, :product_type_id, :product_catalog_id
  end
end
