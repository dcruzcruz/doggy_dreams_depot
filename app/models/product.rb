class Product < ApplicationRecord

  def self.ransackable_associations(auth_object = nil)
    ["carts", "category", "order_items", "wishlists"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "sku", "stock", "updated_at"]
  end

  belongs_to :category
  has_many :order_items
  has_many :carts
  has_many :wishlists

  has_one_attached :image
end
