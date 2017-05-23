class AddUserUuidToCartItems < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :user_id, :integer
    add_column :cart_items, :user_uuid, :string

    add_index :cart_items, [:user_id]
    add_index :cart_items, [:user_uuid]
  end
end
