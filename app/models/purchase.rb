class Purchase < ActiveRecord::Base
	attr_accessible :price, :comment, :transactions_attributes

  has_many :transactions, :dependent => :destroy
  # has_many :products, :through => :transactions

	accepts_nested_attributes_for :transactions

	scope :last_30_days, where(:created_at => (DateTime.now.beginning_of_day - 30.days)..(DateTime.now))
	scope :last_7_days, where(:created_at => (DateTime.now.beginning_of_day - 7.days)..(DateTime.now))
end