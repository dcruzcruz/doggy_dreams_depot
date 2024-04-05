ActiveAdmin.register Product do
  permit_params :sku,:product_name, :description, :price, :stock, :category_id, :image

  remove_filter :image_attachment, :image_blob

  index do
    selectable_column
    id_column
    column :product_name
    column :sku
    column :description
    column :price
    column :stock
    column :category
    actions
  end

  filter :product_name
  filter :sku
  filter :description
  filter :category

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :sku
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

end
