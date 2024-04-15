class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true
  validates :phone_number, presence: true
end
