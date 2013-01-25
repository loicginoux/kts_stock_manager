class Transaction < ActiveRecord::Base
	attr_accessible :action, :product_id, :total_price, :quantity, :bill_id, :purchase_id

  belongs_to :bill
  belongs_to :purchase
  belongs_to :product

	ACTION = [["Sell", "sell"],["Buy", "buy"]]
end