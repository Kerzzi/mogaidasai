class AddMoreDetailToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :product_id, :integer
    add_column :orders, :address_id, :integer
    add_column :orders, :order_no, :string
    add_column :orders, :amount, :integer
    add_column :orders, :payment_at, :datetime

    add_index :orders, [:user_id]
    add_index :orders, [:order_no], unique: true
  end
end
