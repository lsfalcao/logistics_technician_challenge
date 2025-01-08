class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.date :date, index: true

      t.timestamps
    end
  end
end
