class Bill < ActiveRecord::Base
	attr_accessible :transactions_attributes, :price, :comment

  has_many :transactions, :dependent => :destroy
  has_many :products, :through => :transactions

	accepts_nested_attributes_for :transactions

end