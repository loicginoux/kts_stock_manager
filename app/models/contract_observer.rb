class ContractObserver < ActiveRecord::Observer
	observe :contract
	def after_create(c)
		trans = Transaction.new({
			:action => "sell",
			:quantity => 1,
			:contract_id => c.id,
			:total_price => c.paid
			})
		trans.save()
	end

	def after_update(c)
		if c.paid_changed?
			c.transaction.update_attributes(:total_price => c.paid)
		end
	end

	def after_destroy(c)
		if c.transaction && c.transaction.bill
			c.transaction.bill.destroy()
		end
	end

end