class AddinstructorToAdminUsers < ActiveRecord::Migration
  def change
  	add_column :admin_users, :role, :string
  	add_column :admin_users, :first_name, :string
  	add_column :admin_users, :last_name, :string
  	add_column :admin_users, :tel, :string
  end
end
