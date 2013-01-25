class Transaction < ActiveRecord::Base
	attr_accessible :action, :product_id, :total_price, :quantity, :bill_id, :purchase_id, :second_hand_product_id

  belongs_to :bill
  belongs_to :purchase
  belongs_to :product
  belongs_to :second_hand_product

  scope :onNewProduct, where(:second_hand_product_id => nil)
  scope :onSecondHandProduct, where(:product_id => nil)

	ACTION = [["Sell", "sell"],["Buy", "buy"]]
end