ActiveAdmin.register User do
	menu :parent => "Second Hand", :label => "Owners"

	######################
	#  index
	######################


	# filter :name
	filter :first_name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :last_name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :comment
	filter :tel
	filter :email

	index do
		selectable_column
		column :id
		column :first_name
		column :last_name
		column :tel
		column :email
		default_actions
	end

	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :first_name
			f.input :last_name
			f.input :tel
			f.input :email
			f.input :address
			if f.object.new_record?
				f.input :role, :as => :select, :collection => User::ROLE, :selected => "owner"
			else
			f.input :role, :as => :select, :collection => User::ROLE
			end
			f.input :comment
		end
	  f.buttons

	end

		######################
	#  show
	######################

	show do |user|
		attributes_table do
			row :first_name
			row :last_name
			row :tel
			row :email
			row :address
			row :comment
		end
		panel "Second Hand Material" do
	    table_for user.second_hand_products do
	      column "Name" do |prod|
					link_to prod.name, "/admin/second_hand_products/#{prod.id}"
				end
	      column :brand
	      column "State" do |prod|
					prod.state_to_s
				end
	      column :owner_price
	    end
  	end
	end

end