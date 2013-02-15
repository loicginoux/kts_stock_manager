ActiveAdmin.register AdminUser do
  menu :priority => 1, :label=> "Staff"

  scope :all, :default => true
  scope :instructors

  filter :first_name
  filter :last_name

  index :title => "Staff" do
    column :first_name
    column :last_name
    column :email
    column :role
    default_actions
  end

  show do |a|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :tel
      row :role
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end

  end
  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :tel
      f.input :role, :as => :select, :collection => AdminUser::ROLE
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
