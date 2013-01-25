class Distributor < ActiveRecord::Base
  attr_accessible :address, :description, :email, :name, :tel

  has_many :products, :through => :brands
  has_many :brands

  validates :name, :presence => true

end
