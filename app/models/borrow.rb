class Borrow < ActiveRecord::Base
	attr_accessible :material_id,
	:rental_id,
	:lesson_id,
	:quantity

	belongs_to :material
	belongs_to :rental
	belongs_to :lesson
end