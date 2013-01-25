class RemovePolymorphicTransaction < ActiveRecord::Migration
  def change
    remove_index :transactions,  :transactionable_id
    remove_index :transactions, :transactionable_type
    remove_column :transactions, :transactionable_id
    remove_column :transactions, :transactionable_type
    add_column :transactions, :bill_id, :integer
    add_column :transactions, :purchase_id, :integer
    add_column :transactions, :action, :string
    add_index :transactions, :bill_id
    add_index :transactions, :purchase_id
  end
end
