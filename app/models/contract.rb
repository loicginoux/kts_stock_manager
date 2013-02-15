class Contract < ActiveRecord::Base
	attr_accessible :contract_type,
	:hours,
	:done_hours,
	:user_id,
  :total_price,
  :paid,
  :payment_method,
  :comment

	belongs_to :user
  has_and_belongs_to_many :lessons
	has_one :transaction

	accepts_nested_attributes_for :lessons

	TYPE = [
    ["Private", "private"],
    ["Semi Private", "semi_private"],
    ["Group", "group"]
  ]

  scope :active, lambda {
    Contract.where("contracts.hours > contracts.done_hours")
  }
  scope :finished, lambda {
    Contract.where("contracts.hours <= contracts.done_hours")
  }
  scope :waiting_for_payment, lambda {
    Contract.where("(contracts.hours < contracts.done_hours) OR (contracts.total_price > contracts.paid)")
  }

  def hours_left
    self.hours - self.done_hours
  end

  def need_to_pay
    self.total_price - self.paid
  end

  def type_to_s
    case self.contract_type
    when "semi_private"
      "Semi Private"
    else
      self.contract_type.capitalize
    end
  end
end