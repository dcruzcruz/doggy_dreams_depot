class Province < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["users_id_eq", "created_at", "gst_rate", "hst_rate", "id", "name", "pst_rate", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end

  has_many :users, dependent: :destroy
end
