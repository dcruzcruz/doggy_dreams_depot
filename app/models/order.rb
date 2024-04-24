class Order < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "id", "order_date", "total_price", "updated_at"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[orders_id_eq] # Add 'reset_password_token' if you want to allow searching for it
  end

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy
  has_one :shipment, dependent: :destroy

  validates :order_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  def gst
    order_items.sum { |item| (item.price * item.quantity) * 0.05 } # Assuming 5% GST
  end

  def pst
    order_items.sum { |item| (item.price * item.quantity) * 0.07 } # Assuming 7% PST, modify as needed
  end

  def total_tax
    gst + pst
  end

  def total_price
    order_items.sum { |item| item.price * item.quantity } + total_tax
  end

end
