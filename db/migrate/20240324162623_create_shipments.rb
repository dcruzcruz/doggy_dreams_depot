class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.datetime :shipment_date
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
