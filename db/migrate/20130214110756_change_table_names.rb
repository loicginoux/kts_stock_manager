class ChangeTableNames < ActiveRecord::Migration
  def up
  	rename_table :rents, :rentals
  	rename_index :borrows, :rent_id, :rental_id
  	rename_column :borrows, :rent_id, :rental_id
  	rename_column :transactions, :rent_id, :rental_id
  end

  def down
  	rename_table :rentals, :rents
  	rename_index :borrows, :rental_id, :rent_id
  	rename_column :borrows, :rental_id, :rent_id
  	rename_column :transactions, :rental_id, :rent_id
  end
end
