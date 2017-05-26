class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :reviews, dependent: :destroy
  has_many :favorites
  has_many :favorite_products, :through => :favorites, :source => :product

  def is_fan_of?(group)
    favorite_products.include?(group)
  end

  def admin?
    is_admin
  end
end
