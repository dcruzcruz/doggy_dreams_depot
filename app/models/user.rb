class User < ApplicationRecord

  def self.ransackable_associations(auth_object = nil)
    ["carts", "orders", "province", "wishlists"]
  end

  # Define which attributes are searchable by Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[email address phone_number province_id reset_password_token]
  end

  # Define which associations are searchable by Ransack
  def self.ransackable_associations(auth_object = nil)
    ["carts", "orders", "province", "wishlists"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  belongs_to :province
  #has_many :orders
  #has_many :carts
  #has_many :wishlists

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
