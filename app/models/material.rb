class Material < ActiveRecord::Base
	attr_accessible :name,
	:description,
	:quantity,
	:color,
	:size,
	:year,
	:brand_id,
	:product_id,
	:category_id

	belongs_to :brand
	belongs_to :category
	has_many :borrows

end