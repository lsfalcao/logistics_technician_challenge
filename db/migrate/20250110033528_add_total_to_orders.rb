class AddTotalToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :total, :decimal, precision: 11, scale: 2
  end
end
