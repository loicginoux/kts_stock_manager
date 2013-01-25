class AddSecondHandProductToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :second_hand_product_id, :integer
  	add_index :transactions, :second_hand_product_id
  end
end
