class Lesson < ActiveRecord::Base
	attr_accessible :instructor_id,
	:hours,
	:date,
	:lesson_type,
	:comment,
	:contract_ids


  belongs_to :instructor, :class_name => 'AdminUser'
  belongs_to :student, :class_name => 'User'
  has_and_belongs_to_many :contracts
  has_many :users, :through => :contracts
  has_many :borrows

	just_define_datetime_picker :date, :add_to_attr_accessible => true
end