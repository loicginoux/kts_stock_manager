class AddBillComment < ActiveRecord::Migration
  def change
  	add_column :bills, :comment, :text
  end
end
