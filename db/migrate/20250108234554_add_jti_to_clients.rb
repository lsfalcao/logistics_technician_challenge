class AddJtiToClients < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :jti, :string, null: false
    add_index :clients, :jti, unique: true
  end
end
