class SecondHandProduct < ActiveRecord::Base
  attr_accessible :name,
  								:description,
  								:color,
  								:size,
  								:year,
  								:owner_price,
  								:commission,
  								:state,
  								:category_ids,
  								:brand_id,
  								:user_id

  belongs_to :brand
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :pictures

  validates :name, :presence => true
  validates :owner_price, :presence => true
  validates :commission, :presence => true

  scope :in_stock, where(:state => "in_stock")
  scope :sold, where(:state => "sold")
  scope :owner_paid, where(:state => "owner_paid")

  STATE = [
    ["In Stock", "in_stock"],
    ["Sold", "sold"],
    ["Owner Paid", ["owner_paid"]]
  ]

  def state_to_s
    case self.state
    when "in_stock"
      "In Stock"
    when "owner_paid"
      "Owner Paid"
    else
      self.state.capitalize
    end
  end

  def selling_price
    self.owner_price + self.owner_price * self.commission/100
  end


end