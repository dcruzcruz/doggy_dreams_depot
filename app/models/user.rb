class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province

  # Add the address attribute
  attribute :address, :string
  attribute :province

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[email address province_id] # Add 'address' if you want to allow searching for it
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[province_id_lt province_id_gt province_id_eq email reset_password_token address_cont address_eq address_start address_end] # Add 'reset_password_token' if you want to allow searching for it
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
