ActiveAdmin.register SecondHandProduct do
	menu :parent => "Second Hand", :priority => 1, :label => "Second Hand Products"

	######################
	#  index
	######################
	scope :all, :default => true
	scope :in_stock
  scope :sold
  scope :owner_paid

	filter :name, :as => :string, :required => false, :wrapper_html => {:style => "list-style: none"}
	filter :brand
	filter :state, :as => :select, :collection => SecondHandProduct::STATE
	filter :user, :label => "Owner"
	filter :categories_id, :as => :check_boxes, :collection => proc { Category.all }
	filter :size
	filter :year
	filter :owner_price

	index do
		selectable_column
		column :name
		column :brand
		column "Owner", :user
		column :color
		column :size
		column :year
		column :owner_price
		column :selling_price
		column :state do |prod|
			prod.state_to_s
		end
		default_actions
	end

	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			if f.object.new_record?
				f.input :state, :as => :select, :collection => SecondHandProduct::STATE, :selected => "in_stock"
			else
				f.input :state, :as => :select, :collection => SecondHandProduct::STATE
			f.input :name
			f.input :brand
			f.input :user, :label => "Owner", :as => :select, :collection => User.where(:role => "owner").map{|u| [u.full_name, u.id]}
			f.input :description, :hint => "you can add here the state of the material"
			f.input :color
			f.input :size
			f.input :year
			f.input :owner_price
			f.input :commission, :label => "Commission (%)",:input_html => {:value => 10}
			f.input :categories, :as => :check_boxes
			end
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
			row "Owner" do |prod|
				link_to prod.user.full_name, admin_user_path(prod.user)
			end
			row "State" do |prod|
				prod.state_to_s
			end
			row :description
			row :color
			row :size
			row :year
			row :owner_price
			row :commission
			row :selling_price

		end

	end

	######################
	#  control
	######################


	controller do
		# autocomplete :product, :name
		def autocomplete_name
			if params[:state]
				@products = SecondHandProduct.select([:id, :name, :owner_price, :commission]).where(:state => params[:state]).find(:all,:conditions => ['name LIKE ?', "%#{params[:term]}%"],  :limit => 5, :order => 'name')
			else
				@products = SecondHandProduct.select([:id, :name, :owner_price, :commission]).find(:all,:conditions => ['name LIKE ?', "%#{params[:term]}%"],  :limit => 5, :order => 'name')
			end
			respond_to do |format|
				format.html # autocomplete_name.html.erb
				format.xml  { render :xml => @products }
				format.js # autocomplete_name.js.erb
				format.json { render :json => @products }
			end
		end
	end
end