class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :province
  has_many :carts, dependent: :destroy

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
    %w[carts_id_eq phone_number_end phone_number_start phone_number_eq phone_number_cont last_name_end last_name_start last_name_eq last_name_cont first_name_end first_name_start first_name_eq first_name_cont province_id_lt province_id_gt province_id_eq email reset_password_token address_cont address_eq address_start address_end] # Add 'reset_password_token' if you want to allow searching for it
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
