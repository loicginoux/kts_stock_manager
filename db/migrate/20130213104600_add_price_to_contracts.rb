class AddPriceToContracts < ActiveRecord::Migration
  def change
  	add_column :contracts, :total_price, :integer
  	add_column :contracts, :paid, :integer
  	add_column :contracts, :payment_method, :string
  	add_column :contracts, :comment, :text
  end
end
