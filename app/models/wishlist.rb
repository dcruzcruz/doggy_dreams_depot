class Wishlist < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "id", "product_id", "updated_at"]
  end

  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true

end
