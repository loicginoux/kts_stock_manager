class TransactionObserver < ActiveRecord::Observer
	observe :transaction
  def after_create(trans)
  	prod = trans.product
  	prodQuantity = prod.quantity
  	multiplicator = (trans.action == "sell") ? 1 : -1
    prod.update_attributes(:quantity => prodQuantity - trans.quantity * multiplicator )
  end

  def after_update(trans)
  	# only product changed
  	if trans.product_id_changed? && !trans.quantity_changed?
  		newProd = Product.find(trans.product_id)
  		oldProd = Product.find(trans.product_id_was)
  		multiplicator = (trans.action == "sell") ? 1 : -1
  		newProd.update_attributes(:quantity => newProd.quantity - trans.quantity * multiplicator )
  		oldProd.update_attributes(:quantity => oldProd.quantity + trans.quantity * multiplicator )
  	# only quantity changed
	  elsif trans.quantity_changed? && !trans.product_id_changed?
  		prod = trans.product
	  	prodQuantity = prod.quantity
  		oldQuantity = trans.quantity_was
  		newQuantity = trans.quantity
  		multiplicator = (trans.action == "sell") ? 1 : -1
    	prod.update_attributes(:quantity => prodQuantity + (oldQuantity - newQuantity) * multiplicator )
    # both quantity and product changed
    elsif trans.product_id_changed? && trans.quantity_changed?
    	newProd = Product.find(trans.product_id)
  		oldProd = Product.find(trans.product_id_was)
  		oldQuantity = trans.quantity_was
  		newQuantity = trans.quantity
  		multiplicator = (trans.action == "sell") ? 1 : -1
  		newProd.update_attributes(:quantity => newProd.quantity - newQuantity * multiplicator )
  		oldProd.update_attributes(:quantity => oldProd.quantity + oldQuantity * multiplicator )
  	end
  end

  def after_destroy(trans)
		prod = trans.product
  	prodQuantity = prod.quantity
  	multiplicator = (trans.action == "sell") ? 1 : -1
    prod.update_attributes(:quantity => prodQuantity + trans.quantity * multiplicator)
  end
end
