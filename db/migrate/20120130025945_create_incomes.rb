class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :basic_year
      t.string :basic_amount_main
      t.string :basic_currency_main
      t.string :basic_amount_other
      t.string :basic_currency_other
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :incomes, :user_id
  end
end
