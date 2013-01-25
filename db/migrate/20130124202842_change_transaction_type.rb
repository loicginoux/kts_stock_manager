class ChangeTransactionType < ActiveRecord::Migration
  def change
  	remove_column :transactions, :type
  	add_column :transactions, :action, :string
  end
end
