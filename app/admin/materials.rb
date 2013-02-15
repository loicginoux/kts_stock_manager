ActiveAdmin.register Material do
  menu :parent => "School", :label => "Equipments"

  filter :name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :brand
	filter :category
	filter :size
	filter :color
	filter :year
	filter :description

	index :title => "Equipments" do
		column :name
		column :brand
		column :category
		column :quantity
		column :description
		column :color
		column :size
		column :year
		default_actions
	end

	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :name
			f.input :brand
			f.input :category
			f.input :quantity, :as => :select, :collection => 1..20
			f.input :description
			f.input :color
			f.input :size
			f.input :year
		end
	  f.buttons

	end

	######################
	#  show
	######################

	show do |prod|
		attributes_table do
			row :name
			row :brand
			row :category
			row :quantity
			row :description
			row :color
			row :size
			row :year
		end

	end

	######################
	#  control
	######################
	controller do
		def autocomplete_name
			@materials = Material.select([:id, :name, :quantity]).find(:all,:conditions => ['name LIKE ?', "%#{params[:term]}%"],  :limit => 5, :order => 'name')
			respond_to do |format|
				format.html # autocomplete_name.html.erb
				format.xml  { render :xml => @materials }
				format.js # autocomplete_name.js.erb
				format.json { render :json => @materials }
			end
		end
	end
end
