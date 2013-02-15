class AddBaseSchool < ActiveRecord::Migration
  def change
  	create_table :contracts do |t|
  		t.string :contract_type
  		t.integer :hours
  		t.integer :done_hours
  		t.integer :user_id
  		t.timestamps
  	end

		create_table :lessons do |t|
  		t.integer :contract_id
  		t.integer :student_id
  		t.integer :instructor_id
  		t.integer :hours
  		t.datetime :date
  		t.string :lesson_type
  		t.text :comment
			t.timestamps
  	end

		create_table :materials do |t|
			t.string :name
			t.string :description
			t.string :quantity
			t.string :color
			t.string :size
			t.string :year
			t.integer :brand_id
			t.integer :category_id
  		t.timestamps
  	end

  	create_table :rents do |t|
  		t.datetime :start_time
  		t.datetime :end_time
  		t.integer :price
  		t.integer :deposit
  		t.string :document_left
  		t.integer :user_id
  		t.text :comment
  		t.timestamps
  	end

		create_table :disponibilities do |t|
  		t.datetime :start_time
  		t.datetime :end_time
  		t.integer :user_id
  		t.text :comment
  		t.timestamps
  	end

  	create_table :borrows do |t|
      t.integer :material_id
      t.integer :rent_id
      t.integer :lesson_id
      t.integer :quantity
    end

    add_column :users, :language, :string
    add_column :users, :nationality, :string
    add_column :users, :level, :text
    add_column :users, :size, :string
    add_column :users, :accept_conditions, :boolean

  	add_index :contracts, :user_id
  	add_index :lessons, :student_id
  	add_index :lessons, :instructor_id
  	add_index :lessons, :contract_id
  	add_index :rents, :user_id
  	add_index :materials, :brand_id
  	add_index :materials, :category_id
  	add_index :borrows, :material_id
  	add_index :borrows, :rent_id
  	add_index :borrows, :lesson_id
  	add_index :disponibilities, :user_id

  end
end
