class RemoveSpecFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :spec
  end
end
