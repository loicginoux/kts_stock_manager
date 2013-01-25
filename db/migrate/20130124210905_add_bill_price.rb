class AddBillPrice < ActiveRecord::Migration
  def change
  	add_column :bills, :price, :decimal
  end
end
