class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_one :payment
  has_one :shipment

  validates :order_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :customer_id, presence: true

end
