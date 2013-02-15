ActiveAdmin.register User do
	menu :label => "Clients", :parent => "Clients"
	######################
	#  index
	######################

	scope :all
	scope :second_hand_product_owners
	scope :students
	scope :rentals


	filter :client, :as => :string
	filter :nationality

	index :title => "Clients" do
		column :id
		column :first_name
		column :last_name
		column :tel
		column :email
		column :nationality
		if params[:scope] == 'all'
			column :role
		end
		if params[:scope] == 'rentals' || params[:scope] == 'students'
			column "rented material" do |u|
				u.rentals.active().map { |r|
					r.borrows.map{ |b|
						link_to "#{b.quantity} #{b.material.name}", admin_rental_path(r)
					}.join("<br />").html_safe
				}.join("<br />").html_safe
			end
		end
		if params[:scope] == 'second_hand_product_owners'
      column "items in shop" do |u|
      	u.second_hand_products.map { |p| link_to p.name, admin_second_hand_product_path(p)}.join("<br />").html_safe
      end
    end
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
			f.input :nationality
			f.input :language
			f.input :size
			f.input :role, :as => :select, :collection => User::ROLE
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
			row :nationality
			row :language
			row :size
			row :level
			row :comment
		end
		if user.lessons.length > 0
			panel "Previous Lessons" do
		    table_for user.lessons do
		    	column :instructor
		    	column :hours
		    	column :date
		    	column :lesson_type
		    end
		  end
		end
		if user.rentals.length > 0
			panel "Rentals" do
		    table_for user.rentals do
		      column :start_time
		      column :end_time
		      column :price
		      column :deposit
		      column :document_left
		      column :comment
		      column :materials do |r|
						r.borrows.map { |b| "#{b.quantity} #{b.material.name}" }.join("<br />").html_safe
					end
		    end
	  	end
		end
		if user.second_hand_products.length > 0
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



	######################
	#  control
	######################


	controller do
		def autocomplete_name
			@users = User.select(["users.id",
					"users.first_name",
					"users.last_name"
				])
				.where('users.first_name LIKE ? OR users.last_name LIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
				.order("users.last_name")

			respond_to do |format|
				format.json { render :json => @users }
			end
		end
	end
end