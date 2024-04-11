class Wishlist < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "product_id", "updated_at"]
  end

  belongs_to :customer
  belongs_to :product

  validates :customer_id, presence: true
  validates :product_id, presence: true

end
