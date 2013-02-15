class AddContractToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :contract_id, :integer
  end
end
