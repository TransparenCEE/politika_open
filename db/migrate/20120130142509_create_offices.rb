class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :basic_type
      t.string :basic_name
      t.string :basic_sector
      t.string :basic_form
      t.string :basic_number
      t.date :basic_date_from
      t.date :basic_date_to
      t.string :basic_amount
      t.string :basic_currency
      t.string :basic_timeframe
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      t.string :address_contact
      
      t.text :other_note
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :offices, :user_id
  end
end
