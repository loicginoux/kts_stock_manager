# encoding: UTF-8
ActiveAdmin.register Bill do
	menu :parent => "Cash Control", :label => "In"

	index :title => "Bills" do
		column :id
		column "Total Price", :sortable => :price  do |b|
			"#{b.price} €"
		end
		column :comment
		column "Date", :sortable => :created_at do |l|
			l.created_at.to_s(:db)
		end
		default_actions
	end

	filter :price
	filter :created_at, :label => "Date"
	filter :comment

	form do |f|
		f.inputs "transactions" do
			f.has_many :transactions do |trans|
				trans.input :action, :as => :hidden, :input_html => { :value => "sell" }
				trans.input :product_id,
						:as => :string,
						:input_html => {:class => "product", :style => "width:76%" }
				if trans.object.new_record?
					trans.input :quantity, :as => :select, :collection => 1..20 , :selected => "1", :input_html =>{:class => "quantity" }
				else
					trans.input :quantity, :as => :select, :collection => 1..20 , :input_html =>{:class => "quantity" }
				end
				trans.input :total_price, :label => "Price (€)", :input_html =>{:class => "total_price" }
			end
			f.input :price, :label => "Total Price (€)", :hint => "calculated automatically but you can modify it later for discount"
			f.input :comment
		end

		f.buttons

	end

	show do |bill|
		attributes_table do
			row "Price" do |b|
				"#{b.price} €"
			end
			row :created_at
			row :comment
		end
		if bill.transactions.onSchoolClasses().length > 0
			panel "Classes" do
		    table_for bill.transactions.onSchoolClasses() do
		    	column "Contract Id" do |trans|
						link_to trans.contract.id, admin_contract_path(trans.contract)
					end
		      column "Student" do |trans|
						link_to trans.contract.user.full_name, admin_user_path(trans.contract.user.full_name)
					end
					column "Total course price" do |trans|
						"#{trans.contract.total_price} €"
					end
					column "price paid" do |trans|
						"#{trans.contract.paid} €"
					end
		      column "Contract type" do |trans|
						trans.contract.contract_type
					end
		    end
	  	end
		end
		if bill.transactions.onNewProduct().length > 0
			panel "New Products" do
		    table_for bill.transactions.onNewProduct() do
		      column :product
		      column "Brand" do |trans|
						trans.product.brand.name
					end
		      column :quantity
		      column "Unit Price" do |trans|
						"#{trans.product.selling_price} €"
					end
		      column "Price" do |trans|
		      	"#{trans.total_price} €"
		      end
		    end
	  	end
		end
		if bill.transactions.onSecondHandProduct().length > 0
	  	panel "Products" do
		    table_for bill.transactions.onSecondHandProduct() do
		      column :second_hand_product
		      column "Price" do |trans|
		      	"#{trans.total_price} €"
		      end
		    end
	  	end
  	end
  	if bill.transactions.onRentals().length > 0
	  	panel "Rentals" do
		    table_for bill.transactions.onRentals() do
		      column :rental
		    end
	  	end
  	end
	end


end
