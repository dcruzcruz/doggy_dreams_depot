class Category < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true

end
