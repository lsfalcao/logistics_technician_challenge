class AddLegacyIdToObjects < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :legacy_id, :bigint
    add_column :orders, :legacy_id, :bigint
    rename_column :order_products, :product_id, :legacy_product_id
  end
end
