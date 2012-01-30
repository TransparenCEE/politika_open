class CreateMoneyProperties < ActiveRecord::Migration
  def change
    create_table :money_properties do |t|
      t.string :basic_year
      t.string :basic_value
      t.string :basic_currency
      t.text :basic_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :money_properties, :user_id
  end
end
