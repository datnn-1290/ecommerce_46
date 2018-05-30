class AddQuantityBoughtToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :quantity_bought, :integer, default: 0
  end
end
