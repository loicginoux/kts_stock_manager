class User < ActiveRecord::Base
  attr_accessible :first_name,
                  :last_name,
                  :comment,
                  :tel,
                  :email,
                  :address,
                  :role

  has_many :second_hand_products
  has_many :classes

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  ROLE = [
    ["Second Hand Product Owner", "owner"],
    ["Student", "student"],
    ["Instructor", "instructor"],
    ["Renting", "Renting"]
  ]


  scope :owners, where(:role => "owner")
  scope :with_material_sold, joins(:second_hand_products).where("second_hand_products.state = 'sold'")

  def full_name
    self.first_name + " " + self.last_name
  end
end