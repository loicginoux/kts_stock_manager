# encoding: UTF-8
ActiveAdmin.register Purchase do
	menu :parent => "Cash Control", :label => "Out"

	filter :price
	filter :created_at, :label => "Date"
	filter :comment

	index :title => "Stock Purchases" do
		column :id
		column "Price" do |p|
			"#{p.price} €"
		end
		column :comment
		column "Date" do |l|
			l.created_at.to_s(:db)
		end
		default_actions
	end



	form do |f|
		f.inputs "transactions" do
			f.has_many :transactions do |trans|
				trans.input :action, :as => :hidden, :input_html => { :value => "buy" }
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
			row "total Price" do
				"#{bill.price} €"
			end
			row :created_at
			row :comment
		end
		panel "Products" do
	    table_for bill.transactions do
	      column :product
	      column "Brand" do |trans|
					trans.product.brand.name
				end
	      column :quantity
	      column "Unit Price" do |trans|
					"#{trans.product.selling_price} €"
				end
	      column "Price" do |t|
	      	"#{t.total_price} €"
	      end
	    end
  	end
	end
end