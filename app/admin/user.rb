ActiveAdmin.register User do
  show do |ad|
    attributes_table do
      row :id
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :username
      row :name
      row :user_group
    end
    active_admin_comments
  end
end
