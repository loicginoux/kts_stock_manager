class ChangeRelationContractsClasses < ActiveRecord::Migration
  def up

    remove_index :lessons, :contract_id
		remove_index :lessons, :student_id

  	remove_column :lessons, :contract_id
  	remove_column :lessons, :student_id

		create_table 'contracts_lessons', :id => false do |t|
      t.integer :contract_id
      t.integer :lesson_id
    end

  end

  def down
  	add_column :lessons, :contract_id, :integer
  	add_column :lessons, :student_id, :integer
  	remove_table :contracts_lessons
  	add_index :lessons, :contract_id
  	add_index :lessons, :student_id

  end
end
