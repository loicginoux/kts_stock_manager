class CreateBase < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.string :name
      t.text :description
      t.string :tel
      t.string :email
      t.text :address
    end

    create_table :brands do |t|
      t.string :name
      t.text :description
      t.string :website
    end

    create_table :categories do |t|
      t.string :name
      t.text :description
    end

    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.string :color
      t.string :size
      t.integer :year
      t.decimal :cost_price
      t.decimal :selling_price

      t.integer :brand_id
      t.integer :distributor_id

    end

    add_index :products, :brand_id
    add_index :products, :distributor_id

    create_table 'categories_products', :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end

    create_table :pictures do |t|
      t.string :name
      t.text :description

      t.integer :product_id

    end

    add_index :pictures, :product_id
  end
end
