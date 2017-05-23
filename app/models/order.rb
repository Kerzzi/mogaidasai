class Order < ApplicationRecord

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true
  validates :order_no, uniqueness: true

  before_create :gen_order_no

  belongs_to :user
  belongs_to :address
  belongs_to :product
  has_many :product_lists



  # validates :billing_name, presence: true
  # validates :billing_address, presence: true
  # validates :shipping_name, presence: true
  # validates :shipping_address, presence: true

  # def generate_token
  #   self.token = SecureRandom.uuid
  # end

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  def pay!
    self.update_columns(is_paid: true )
  end

  def self.create_order_from_cart_items! user, address, *cart_items
    cart_items.flatten!
    address_attrs = address.attributes.except!("id", "created_at", "updated_at")

    transaction do
      order_address = user.addresses.create!(address_attrs.merge(
        "address_type" => Address::AddressType::Order
      ))

      cart_items.each do |cart_item|
        user.orders.create!(
          product: cart_item.product,
          address: order_address,
          quantity: cart_item.quantity,
          total_money: cart_item.quantity * cart_item.product.price
        )
      end

      cart_items.map(&:destroy!)
    end
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

end
