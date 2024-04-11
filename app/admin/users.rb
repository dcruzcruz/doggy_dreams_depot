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
