class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
  	:password,
  	:password_confirmation,
  	:remember_me,
  	:first_name,
  	:last_name,
  	:role,
  	:tel
  # attr_accessible :title, :body

	scope :instructors, where(:role => "instructor")

	 ROLE = [
    ["Manager", "manager"],
    ["Instructor", "instructor"]
  ]

  def full_name
    self.first_name + " " + self.last_name
  end
end
