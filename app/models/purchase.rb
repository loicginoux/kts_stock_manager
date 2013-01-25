class Purchase < ActiveRecord::Base
	attr_accessible :price, :comment, :transactions_attributes

  has_many :transactions, :dependent => :destroy
  # has_many :products, :through => :transactions

	accepts_nested_attributes_for :transactions

end