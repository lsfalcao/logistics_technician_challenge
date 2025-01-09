class AddNameToClients < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :name, :string
  end
end
