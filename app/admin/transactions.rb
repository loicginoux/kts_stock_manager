ActiveAdmin.register Transaction do
	menu false

	index do

		column :id
		column :total_price
		column :product
		column :quantity
		default_actions
	end



	# form :partial => "form"
  form do |f|
  	f.inputs "Transaction Details" do
  		f.input :action,:as => :select, :collection => Transaction::ACTION
			if f.object.new_record?
				f.input :product_id, :as => :string, :hint => "Find the product by his name", :input_html => {:class => "product"}
				f.input :quantity, :as => :select, :collection => 1..20 , :selected => "1", :input_html =>{:class => "quantity" }
			else
				f.input :product_id, :as => :string, :hint => "Product name: #{f.object.product.name} - unit price: #{f.object.product.selling_price}", :input_html => {:class => "product", :data_unit_price => f.object.product.selling_price}
				f.input :quantity, :as => :select, :collection => 1..20 , :input_html =>{:class => "quantity" }
			end

			f.input :total_price, :label => "Price", :input_html =>{:class => "total_price" }
  	end
		f.buttons
	end
end
