class AddMoreDetailsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :category_id, :integer
    add_column :products, :status, :string, default: 'off'
    #指示商品状态，如上架、下架，设置为string模式方便后续增加状态数量，而且更为直观

    add_column :products, :uuid, :string
    #uuid是商品的序列号，教材中的不够直观，这样也方便后期增加功能

    add_column :products, :msrp, :decimal, precision: 10, scale: 2
    #msrp是市场建议零售价的缩写，用于打折等

    #养成习惯，建立一张表时，最好将索引建立好，主要用于搜索
    add_index :products, [:status, :category_id]
    add_index :products, [:category_id]
    add_index :products, [:uuid], unique: true  #在数据库层面限制序列号的唯一性

    add_index :products, [:title]
  end
end
