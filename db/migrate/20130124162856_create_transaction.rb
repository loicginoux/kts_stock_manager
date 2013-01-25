class CreateTransaction < ActiveRecord::Migration
	def change
		create_table :transactions do |t|
      t.string :type
      t.integer :product_id
      t.integer :bill_id
      t.decimal :total_price
      t.integer :quantity
      t.timestamp
    end

    add_index :transactions, :product_id
    add_index :transactions, :bill_id

		create_table :bills do |t|
      t.timestamp
    end


	end


end
