class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate

      t.timestamps
    end
  end
end
