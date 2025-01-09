class CreateLegacyOrderImports < ActiveRecord::Migration[7.2]
  def change
    create_table :legacy_order_imports do |t|
      t.references :client, foreign_key: true
      t.text :results

      t.timestamps
    end
  end
end
