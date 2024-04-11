class AddProvinceIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :province_id, :integer, null: false
    add_index :users, :province_id, name: "index_users_on_province_id"
  end
end
