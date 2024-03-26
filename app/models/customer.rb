class Customer < ApplicationRecord
  has_many :orders
  has_many :carts
  has_many :wishlists

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true
  validates :phone_number, presence: true
end
