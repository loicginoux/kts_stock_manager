class Product < ActiveRecord::Base
  attr_accessible :name,
  								:description,
  								:quantity,
  								:color,
  								:size,
  								:year,
  								:cost_price,
  								:selling_price,
  								:categories_attributes,
  								:category_ids,
  								:brand_id,
  								:distributor_id

  belongs_to :brand
  belongs_to :distributor
  has_and_belongs_to_many :categories
  has_many :pictures
  has_many :transactions
  has_many :bill, :through => :transactions

	before_create :default_init_val
  validates :name, :presence => true

	accepts_nested_attributes_for :categories

  scope :in_stock, where("quantity >= 0")
  scope :out_of_stock, where("quantity <= 0")

  def default_init_val
  	if new_record?
    	self.quantity ||= 0
    	self.cost_price ||= 0
    	self.selling_price ||= 0
  	end
  end

end