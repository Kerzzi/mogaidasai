class Payment < ApplicationRecord
  module PaymentStatus
    Initial = 'initial'
    Success = 'success'
    Failed = 'failed'
  end

  belongs_to :user
  has_many :orders

  before_create :gen_payment_no

  private
  def gen_payment_no
    self.payment_no = RandomCode.generate_utoken(32)
  end
  
end
