ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :address, :province_id

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :address
    column :province
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :province
    end
    f.actions
  end

    # Show page for a user
    show do
      attributes_table do
        row :email
        row :first_name
        row :last_name
        row :created_at
      end

      panel "Orders" do
        table_for user.orders do
          column "Order ID", :id
          column "Order Date", :order_date
          column "Total Price" do |order|
            number_to_currency(order.total_price)
          end
          column "Details" do |order|
            table_for order.order_items do
              column "Product" do |item|
                item.product.product_name
              end
              column "Quantity", :quantity
              column "Price" do |item|
                number_to_currency(item.price)
              end
              column "Subtotal" do |item|
                number_to_currency(item.quantity * item.price)
              end
            end
          end
        end
      end
    end




  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :address, :null, :phone_number, :province_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :address, :null, :phone_number, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
