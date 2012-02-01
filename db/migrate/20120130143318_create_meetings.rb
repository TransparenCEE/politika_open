class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :basic_information_type
      t.string :basic_information_purpose
      t.string :basic_information_state
      t.string :basic_information_town
      t.date :basic_information_date_from
      t.date :basic_information_date_to
      t.string :basic_information_payed
      t.string :basic_information_amount
      t.string :basic_information_currency
      t.text :basic_information_notes
      
      t.string :institution_title_or_name
      t.string :institution_sector
      t.string :institution_form
      t.string :institution_number
      t.boolean :institution_no_approvement
      t.string :institution_title
      t.string :institution_name
      t.string :institution_surname
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :meetings, :user_id
  end
end
