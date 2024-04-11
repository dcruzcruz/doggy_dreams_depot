class Order < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "id", "order_date", "total_price", "updated_at"]
  end

  belongs_to :user
  has_many :order_items
  has_one :payment
  has_one :shipment

  validates :order_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

end
