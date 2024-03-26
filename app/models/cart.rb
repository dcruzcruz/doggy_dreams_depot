class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :customer_id, presence: true
  validates :product_id, presence: true

end
