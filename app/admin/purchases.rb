ActiveAdmin.register Purchase do
	menu :parent => "Accounts"

	index do
		selectable_column
		column :id
		column :price
		column :comment
		column :created_at
		default_actions
	end

	filter :price
	filter :created_at

	form do |f|
		f.inputs "transactions" do
			f.has_many :transactions do |trans|
				# trans.input :action,:as => :select, :collection => Transaction::ACTION, :selected => "sell"
				trans.input :action, :as => :hidden, :input_html => { :value => "buy" }
				if trans.object.new_record?
					trans.input :product_id, :as => :string, :hint => "Find the product by his name", :input_html => {:class => "product"}
					trans.input :quantity, :as => :select, :collection => 1..20 , :selected => "1", :input_html =>{:class => "quantity" }
				else
					trans.input :product_id, :as => :string, :hint => "Product name: #{trans.object.product.name} - unit price: #{trans.object.product.selling_price}", :input_html => {:class => "product", :data_unit_price => trans.object.product.selling_price}
					trans.input :quantity, :as => :select, :collection => 1..20 , :input_html =>{:class => "quantity" }
				end

				trans.input :total_price, :label => "Price", :input_html =>{:class => "total_price" }
			end
			f.input :price, :label => "Total Price", :hint => "calculated automatically but you can modify it later for discount"
			f.input :comment
		end

		f.buttons

	end

	show do |bill|
		attributes_table do
			row :price
			row :created_at
			row :comment
			table_for bill.transactions do
				column do |trans|
					attributes_table do
						row "Product" do
							trans.product.name
						end
						row "Brand" do
							trans.product.brand.name
						end
						row "Quantity" do
							trans.quantity
						end
						row "unit price" do
							trans.product.selling_price
						end
						row "Price" do
							trans.total_price
						end
					end
				end
			end
		end
	end
end