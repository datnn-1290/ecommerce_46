class AddTotalToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total, :integer, default: 0
  end
end
