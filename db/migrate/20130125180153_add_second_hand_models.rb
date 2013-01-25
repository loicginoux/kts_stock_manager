class AddSecondHandModels < ActiveRecord::Migration
	def change
		create_table :second_hand_products do |t|
			t.string :name
			t.text :description
			t.string :color
			t.string :size
			t.integer :year
			t.decimal :owner_price
			t.decimal :commission
			t.string :state
			t.integer :brand_id
			t.integer :user_id
		end

		add_index :second_hand_products, :brand_id
		add_index :second_hand_products, :user_id

    create_table 'categories_second_hand_products', :id => false do |t|
      t.integer :category_id
      t.integer :second_hand_product_id
    end

    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :comment
    	t.string :tel
     	t.string :email
      t.text :address
      t.string :role
    end
	end
end
