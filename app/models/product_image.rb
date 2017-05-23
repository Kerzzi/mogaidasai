class ProductImage < ApplicationRecord

  belongs_to :product

  #指定图片尺寸

  has_attached_file :image, styles: {
    small: '200^x200',
    middle: '400^x400',
    big: "960x"
  }

  #限制上传类型

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  #限制上传图片的大小

  validates_attachment_size :image, in: 0..5.megabytes


end
