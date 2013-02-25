# encoding: UTF-8
ActiveAdmin.register Product do
	menu :parent => "Shop", :priority => 2
	######################
	#  index
	######################
	config.batch_actions = false

	# config.batch_actions = true
	# batch_action :destroy,:if => proc { true }, :confirm => "Are you sure you want to delete all of these?" do |selection|
	# 	Product.destroy(selection)
	# 	redirect_to admin_products_path, :notice => "all deleted"
	# end

	scope :in_stock, :default => true
	scope :out_of_stock
	# filter :name
	filter :name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :brand
	filter :distributor
	filter :size
	filter :id
	filter :year
	filter :quantity
	filter :selling_price
	filter :categories_id, :as => :check_boxes, :collection => proc { Category.all }


	index do
		column :id
		column :name
		column :brand, :sortable => :"brands.name"
		column "Qty.", :quantity
		column "Cost Price", :sortable => :cost_price do |p|
			"#{p.cost_price} €"
		end
		column "Selling Price", :sortable => :cost_price do |p|
			"#{p.selling_price} €"
		end
		column :color
		column :size
		column :year
		column :categories do |product|
			product.categories.order('name ASC').map(&:name).join("<br />").html_safe
			# table_for product.categories.order('name ASC') do
			# 	column do |category|
			# 		link_to category.name, [ :admin, category ]
			# 	end
			# end
		end

		default_actions
	end

	######################
	#  show
	######################
	member_action :duplicate, :method => :get do
		p = Product.find(params[:id])
		newP = p.dup
		newP.save
		redirect_to edit_admin_product_path(newP), :notice => "Item Duplicated. You are now editing it."
	end

	action_item :only => :show do
		p = Product.find(params[:id])
		link_to "Duplicate Product", duplicate_admin_product_path(p)
	end
	show do |prod|
		attributes_table do
			row :name
			row :brand
			row :distributor
			row :quantity
			row "Cost Price" do |p|
				"#{p.cost_price} €"
			end
			row "Selling Price" do |p|
				"#{p.selling_price} €"
			end
			row :color
			row :size
			row :year
			row :description
			table_for product.categories.order('name ASC') do
				column "Categories" do |category|
					link_to category.name, [ :admin, category ]
				end
			end
		end

	end

	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :name
			f.input :brand,
				:input_html => { :style => "width:76%" }
			f.input :quantity
			f.input :cost_price, :label => "Cost Price (€)"
			f.input :selling_price, :label => "Selling Price (€)"
			f.input :distributor,
				:input_html => { :style => "width:76%" }
			f.input :categories,
				:as => :select,
				:input_html => { :multiple => true, :style => "width:76%" }
			f.input :color
			f.input :size
			f.input :year
			f.input :description
		end
	  f.buttons

	end
	######################
	#  control
	######################


	controller do
		# autocomplete :product, :name
		def autocomplete_name
			# @products = Product.select([:id, :name, :brand, :selling_price, :color, :size, :year]).find(:all,:conditions => ['name LIKE ?', "%#{params[:term]}%"],  :limit => 10, :order => 'name')
			@products = Product.joins(:brand)
				.select(["products.id",
					"products.name",
					"products.selling_price",
					"products.color",
					"products.size",
					"products.year",
					"products.quantity",
					"products.cost_price",
					"brands.name AS 'brands'"
				])
				.where('products.name LIKE ? OR products.color LIKE ? OR products.size LIKE ? OR products.year LIKE ? OR brands.name LIKE ?', "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
				.order("products.name")

			respond_to do |format|
				format.html # autocomplete_name.html.erb
				format.xml  { render :xml => @products }
				format.js # autocomplete_name.js.erb
				format.json { render :json => @products }
			end
		end
  	def scoped_collection
    	Product.includes(:brand).includes(:distributor)
  	end
	end

end
