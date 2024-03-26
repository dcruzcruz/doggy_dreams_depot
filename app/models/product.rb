class Product < ApplicationRecord

  def self.ransackable_associations(auth_object = nil)
    ["carts", "category", "order_items", "wishlists"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at","product_name", "description", "id", "price", "sku", "stock", "updated_at"]
  end

  belongs_to :category
  has_many :order_items
  has_many :carts
  has_many :wishlists

  has_one_attached :image

  validates :product_name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

end
