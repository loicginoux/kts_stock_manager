class AddStateToRent < ActiveRecord::Migration
  def change
  	add_column :rents, :state, :string
  end
end
