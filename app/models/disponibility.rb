class Disponibility < ActiveRecord::Base
	attr_accessible :start_time,
	:end_time,
	:user_id,
	:comment

	belongs_to :user
end