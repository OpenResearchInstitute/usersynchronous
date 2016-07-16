class AddCallSignAndNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :call_sign, :string
    add_column :users, :name, :string
  end
end
