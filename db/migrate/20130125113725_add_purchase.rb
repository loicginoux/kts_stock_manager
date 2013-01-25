class AddPurchase < ActiveRecord::Migration
  def change
  	create_table :purchases do |t|
  		t.text :comment
  		t.decimal :price
      t.timestamp
    end
    add_column :transactions, :transactionable_id, :integer
    add_column :transactions, :transactionable_type, :string
    remove_index :transactions, :bill_id
    remove_column :transactions, :bill_id
    remove_column :transactions, :action
    add_index :transactions,  :transactionable_id
    add_index :transactions, :transactionable_type
  end
end
