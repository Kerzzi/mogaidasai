class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
        t.string :title
        t.integer :weight, default: 0  #用于权重的字段，方面后续按不同顺序展示商品

        t.integer :products_counter, default: 0  #该分类下的产品数量字段

         t.timestamps
      end
    add_index :categories, [:title]
    #养成习惯建立一张表时，最好将索引建立好，比如搜索功能会用到
  end
end
