class AddProductNameToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_name, :string
  end
end
