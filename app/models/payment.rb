class Payment < ApplicationRecord

  belongs_to :order

  validates :payment_date, presence: true
  validates :payment_method, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order_id, presence: true
end
