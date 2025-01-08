class CreateOrderProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :order_products do |t|
      t.references :order, foreign_key: true
      t.decimal :value, precision: 11, scale: 2
      t.bigint :product_id, index: true

      t.timestamps
    end
  end
end
