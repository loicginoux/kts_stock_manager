class AddBillandTransactionTimestamp < ActiveRecord::Migration
  def change
		add_column(:bills, :created_at, :datetime)
    add_column(:bills, :updated_at, :datetime)
    add_column(:transactions, :created_at, :datetime)
    add_column(:transactions, :updated_at, :datetime)
  end
end
