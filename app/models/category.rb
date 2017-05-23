class Category < ApplicationRecord

  before_validation :correct_ancestry

  validates :title, presence: { message: "名称不能为空" }
  validates :title, uniqueness: { message: "名称不能重复" }

  has_ancestry orphan_strategy: :destroy

  has_many :products, dependent: :destroy

  # 保证可以在多个页面中，取得一二级分类
  def self.grouped_data
    self.roots.order("weight desc").inject([]) do |result, parent|
       row = []
       row << parent
       row << parent.children.order("weight desc")
       result << row
     end
  end

  private
  def correct_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end

end
