class Cart < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "id", "product_id", "quantity", "updated_at", "user_id"]
  end

  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :product_id, presence: true

end
