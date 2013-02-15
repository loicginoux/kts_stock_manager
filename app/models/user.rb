class User < ActiveRecord::Base
  attr_accessible :first_name,
                  :last_name,
                  :comment,
                  :tel,
                  :email,
                  :address,
                  :nationality,
                  :language,
                  :size,
                  :role

  has_many :second_hand_products
  has_many :rentals
  has_many :contracts
  has_many :lessons, :through => :contracts
  has_many :disponibilities

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  ROLE = [
    ["Second Hand Product Owner", "owner"],
    ["Student", "student"],
    ["Rentals", "rentals"]
  ]

  search_methods :client_contains

  scope :client_contains, lambda { |id|
    User.where(:id => id)
  }
  scope :second_hand_product_owners, where(:role => "owner")
  scope :students, where(:role => "student")
  scope :rentals, where(:role => "rentals")
  scope :students_or_rentals, where("role ='student' OR role='rentals'")
  scope :with_material_sold, joins(:second_hand_products).where("second_hand_products.state = 'sold'")
  scope :with_contracts, joins(:contracts).where("contracts.user_id = users.id")
  scope :with_rentals, joins(:rentals).where("rentals.user_id = users.id")
  scope :with_seconde_hand_products, joins(:second_hand_products).where("second_hand_products.user_id = users.id").uniq()

  def full_name
    self.first_name + " " + self.last_name
  end
end