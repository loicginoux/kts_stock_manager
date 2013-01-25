class Brand < ActiveRecord::Base
  attr_accessible :name, :description, :website

  has_many :products

  validates :name, :presence => true
end