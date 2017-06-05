class Order < ApplicationRecord

  before_create :generate_token
  # before_create :gen_order_no
  belongs_to :user
  has_many :product_lists
  belongs_to :payment

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  #这个后面可以废弃了
  def generate_token
    self.token = SecureRandom.uuid
  end


  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  #这个可以删除了
  def pay!
    self.update_columns(is_paid: true )
  end

  #下面这2个方法看看能不能合并
  module OrderStatus
    Initial = 'initial'
    Paid = 'paid'
  end

  def paid?
    self.status == OrderStatus::Paid
    self.update_columns(is_paid: true )
  end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

  # private
  # def gen_order_no
  #   self.order_no = RandomCode.generate_order_uuid
  # end

end
