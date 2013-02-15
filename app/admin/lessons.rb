ActiveAdmin.register Lesson do
  menu :parent => "School"

  filter :student, :collection => User.with_contracts()
  filter :instructor, :collection => AdminUser.instructors()
  filter :lesson_type, :as => :select, :collection => Contract::TYPE
  filter :hours
  filter :date

  index do
		column :instructor
		column "Hours" do |l|
			"#{l.hours} h."
		end
		column "Date" do |l|
			l.date.to_s(:db)
		end
		column "Type", :lesson_type
		column "Students" do |l|
			l.contracts.map { |c| link_to c.user.full_name, admin_user_path(c.user)}.join("<br />").html_safe
		end
		default_actions
	end
	######################
	#  show
	######################

	show do |lesson|
		attributes_table do
			row :instructor
			row "Hours"  do |l|
				"#{l.hours} h."
			end
			row :date
			row :lesson_type
			row :comment
			panel "Students" do
				table_for lesson.contracts do
					column "Contract id" do |c|
						link_to c.id, admin_contract_path(c)
					end
					column :user
					column "Contracted"  do |c|
						"#{c.hours} h."
					end
					column "Done" do |c|
						"#{c.done_hours} h."
					end
					column "left " do |c|
						"#{c.hours_left} h."
					end
					column :contract_type
				end
			end
		end
	end
	######################
	#  edit
	######################
	form do |f|
		f.inputs "Details" do
			f.input :instructor,
				:as => :select,
				:collection => AdminUser.instructors(),
				:input_html => {:style => "width:76%"}
			f.input :hours,
				:as => :select,
				:collection => [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6]
			if f.object.new_record?
				f.input :lesson_type,
					:as => :select,
					:collection => Contract::TYPE,
					:selected => "group"
			else
				f.input :lesson_type,
					:as => :select,
					:collection => Contract::TYPE
			end
			f.input :date,
				:as => :just_datetime_picker
			f.input :contracts,
				:label => "Students",
				:as => :select,
				:collection => Contract.active().map{|c| [c.user.full_name,c.id]},
				:hint => "only students whith active contract",
				:input_html => { :multiple => true, :style => "width:76%" }
			f.input :comment
		end
	  f.buttons

	end
end
