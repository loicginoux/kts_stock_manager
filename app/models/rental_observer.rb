class RentalObserver < ActiveRecord::Observer
	observe :rental
	def after_create(r)
		trans = Transaction.new({
			:action => "sell",
			:quantity => 1,
			:rental_id => r.id,
			:total_price => r.price
			})
		trans.save()
	end
	def after_update(r)
		if r.price_changed?
			r.transaction.update_attributes(:total_price => r.price)
		end
	end
	def after_destroy(r)
		r.transaction.bill.destroy()
	end
end