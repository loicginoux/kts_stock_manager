class AddRentToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :rent_id, :integer
  end
end
