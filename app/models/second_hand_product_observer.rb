class SecondHandProductObserver < ActiveRecord::Observer
	observe :second_hand_product
	def after_update(prod)
		if prod.state_changed?
			if prod.state == "sold"
				trans = Transaction.new({
					:action => "sell",
					:quantity => 1,
					:second_hand_product_id => prod.id,
					:total_price => prod.owner_price * prod.commission/100
				})
				trans.save
			end
		end
	end
end