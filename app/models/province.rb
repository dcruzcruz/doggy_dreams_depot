class Province < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "name", "pst_rate", "updated_at"]
  end

  has_many :customers
  has_many :users
end
