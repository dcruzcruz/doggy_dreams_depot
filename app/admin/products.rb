ActiveAdmin.register Product do
  permit_params :sku, :description, :price, :stock, :category_id

  index do
    selectable_column
    id_column
    column :sku
    column :description
    column :price
    column :stock
    column :category
    actions
  end

  filter :sku
  filter :description
  filter :category

  form do |f|
    f.inputs do
      f.input :sku
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
    end
    f.actions
  end
end
