class AddWeightToProduct < ActiveRecord::Migration
  def change
    add_column :products, :weight, :decimal
  end
end
