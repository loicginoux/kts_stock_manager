ActiveAdmin.register Product do
	menu :parent => "Stock", :priority => 1
	######################
	#  index
	######################
	config.batch_actions = true

	batch_action :destroy,:if => proc { true }, :confirm => "Are you sure you want to delete all of these?" do |selection|
		Product.destroy(selection)
		redirect_to admin_products_path, :notice => "all deleted"
	end

	# filter :name
	filter :name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :brand
	filter :distributor
	filter :categories_id, :as => :check_boxes, :collection => proc { Category.all }
	filter :id
	filter :size
	filter :year
	filter :quantity
	filter :cost_price
	filter :selling_price


	index do
		selectable_column
		column :id
		column :name
		column :brand
		column :distributor
		column :quantity
		column :cost_price
		column :selling_price
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

	show do |prod|
		attributes_table do
			row :name
			row :brand
			row :distributor
			row :quantity
			row :cost_price
			row :selling_price
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
			f.input :brand
			f.input :quantity
			f.input :cost_price
			f.input :selling_price
			f.input :distributor
			f.input :categories, :as => :check_boxes
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
			@products = Product.select([:id, :name, :selling_price]).find(:all,:conditions => ['name LIKE ?', "%#{params[:term]}%"],  :limit => 5, :order => 'name')
			respond_to do |format|
				format.html # autocomplete_name.html.erb
				format.xml  { render :xml => @products }
				format.js # autocomplete_name.js.erb
				format.json { render :json => @products }
			end
		end
	end

end
