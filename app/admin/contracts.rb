# encoding: UTF-8
ActiveAdmin.register Contract do
	menu :parent => "School"

	scope :all, :default => true
	scope :active
	scope :finished
	scope :waiting_for_payment

	filter :user,:label => "Student", :as => :select, :collection => User.with_contracts()
	filter :hours, :label => "Contracted Hours"
	filter :done_hours
	filter :contract_type, :as => :select, :collection => Contract::TYPE

	index do
		column :id
		column "Student", :user
		column "Type", :contract_type
		column "Contracted" do |c|
			"#{c.hours} h."
		end
		column "Done" do |c|
			"#{c.done_hours} h."
		end
		column "Left " do |c|
			"#{c.hours_left} h."
		end
		column "Price" do |c|
			"#{c.total_price} €"
		end
		column "Paid" do |c|
			"#{c.paid} €"
		end
		column "To Be Paid" do |c|
			"#{c.need_to_pay()} €"
		end
		default_actions
	end

	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :user,:as =>:select, :collection => User.students(), :input_html => {:style => "width:76%"}
			f.input :contract_type, :as => :select, :collection => Contract::TYPE, :selected => "group"
			f.input :hours, :label => "Hours Contracted", :as => :select, :collection => 1..20
			f.input :total_price, :label => "Total Price (€)"
			f.input :paid, :label => "Paid (€)"
			f.input :payment_method, :hint => "Cash, Credit Card, etc..."
			f.input :done_hours, :label => "Hours done"
			f.input :comment

		end
	  f.buttons
	end

	######################
	#  show
	######################

	show do |contract|
		attributes_table do
			row "Student" do |c|
				c.user
			end
			row "Type" do |contract|
				contract.type_to_s
			end
			row "Hours Contracted" do |c|
				"#{c.hours} h."
			end
			row "Hours Done" do |c|
				"#{c.done_hours} h."
			end
			row "Total Price" do |c|
				"#{c.total_price} €"
			end
			row "Paid" do |c|
				"#{c.paid} €"
			end
			row :payment_method
			row :comment
			row :created_at
		end
		panel "Lessons Done" do
			table_for contract.lessons do
				column :instructor
				column "Hours" do |l|
					"#{l.hours} h."
				end
				column :date
				column :comment
				column "Actions" do |l|
					link_to "View Lesson", admin_lesson_path(l)

				end
			end
		end
	end
end
