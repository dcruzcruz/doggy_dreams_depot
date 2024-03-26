class Shipment < ApplicationRecord
  belongs_to :order

  validates :shipment_date, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true
  validates :order_id, presence: true

end
