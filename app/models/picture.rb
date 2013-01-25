class Picture < ActiveRecord::Base
  attr_accessible :name
  has_one :product
end