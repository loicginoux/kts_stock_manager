class Rental < ActiveRecord::Base
	attr_accessible :start_time,
	:end_time,
	:state,
	:price,
	:deposit,
	:document_left,
	:user_id,
	:comment,
	:borrows_attributes

	has_many :borrows, :dependent => :destroy
	has_many :materials, :through => :borrows
	has_one :transaction
	belongs_to :user

  STATE = [
    ["Active", "active"],
    ["Returned", "returned"]
  ]

  scope :active, where(:state => "active")
  scope :returned, where(:state => "returned")

	accepts_nested_attributes_for :borrows
	just_define_datetime_picker :start_time, :add_to_attr_accessible => true
	just_define_datetime_picker :end_time, :add_to_attr_accessible => true
end