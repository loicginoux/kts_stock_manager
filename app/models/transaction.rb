class Transaction < ActiveRecord::Base
	attr_accessible :action,
		:product_id,
		:total_price,
		:quantity,
		:bill_id,
		:purchase_id,
		:second_hand_product_id,
		:rental_id,
		:contract_id

  belongs_to :bill
  belongs_to :rental
  belongs_to :purchase
  belongs_to :contract
  belongs_to :product
  belongs_to :second_hand_product

  scope :onNewProduct, where("product_id IS NOT NULL")
  scope :onSecondHandProduct, where("second_hand_product_id IS NOT NULL")
  scope :onRentals, where("rental_id IS NOT NULL")
  scope :onSchoolClasses, where("contract_id IS NOT NULL")

	ACTION = [["Sell", "sell"],["Buy", "buy"]]
end