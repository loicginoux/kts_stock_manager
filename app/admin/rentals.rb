# encoding: UTF-8
ActiveAdmin.register Rental do
  menu :parent => "School"

  scope :active, :default => true
  scope :returned
  ######################
	#  index
	######################

	filter :user, :label => "Client", :as => :select, :collection => User.with_rentals()
	filter :start_time
	filter :end_time

	index do
		column "Client", :user
		column "Start" do |l|
			l.start_time.to_s(:db)
		end
		column "End" do |l|
			l.end_time.to_s(:db)
		end
		column "Total Price" do |r|
			"#{r.price} €"
		end
		column "Deposit" do |r|
			"#{r.deposit} € + #{r.document_left}"
		end
		column :state
		column "Equipments", :materials do |rent|
			rent.borrows.map { |b| "#{b.quantity} #{b.material.name}" }.join("<br />").html_safe
		end
		default_actions
	end


	######################
	#  show
	######################

	show do |rent|
		attributes_table do
			row "Client" do |r|
				link_to r.user.full_name, admin_user_path(r.user)
			end
			row :start_time
			row :end_time
			row :state
			row "Total Price" do |r|
				"#{r.price} €"
			end
			row  "Deposit" do |r|
				"#{r.deposit} €"
			end
			row :document_left
			row :comment
			panel "Materials" do
				table_for rent.borrows do |b|
					column :quantity
					column :material
				end
			end
		end

	end


  ######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :user,
				:as =>:select,
				:input_html => {:style => "width:76%"},
				:collection => User.students_or_rentals()
			f.input :start_time, :as => :just_datetime_picker
			f.input :end_time, :as => :just_datetime_picker
			if f.object.new_record?
				f.input :state, :as => :select, :collection => Rental::STATE , :selected => "active"
			else
				f.input :state, :as => :select, :collection => Rental::STATE
			end
			f.input :price, :label => "Total Price(€)"
			f.input :deposit, :label => "Deposit(€)",  :hint => "how much deposit is left, if any."
			f.input :document_left, :hint => "ID, Passport, Driving License, etc..."
			f.input :comment
			f.has_many :borrows do |b|
				b.input :material, :input_html => {:class => "material", :style => "width:76%"}
				b.input :quantity, :as => :select, :collection => 1..20 , :input_html =>{:class => "quantity" }
			end
		end
	  f.buttons

	end
end
