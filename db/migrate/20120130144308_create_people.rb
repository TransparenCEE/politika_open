class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :basic_relation
      t.boolean :basic_no_approvement
      
      t.string :information_title
      t.string :information_name
      t.string :information_surname
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      
      
      t.boolean :ownership_not_presented
      t.boolean :ownership_none
      t.boolean :ownership_not_known
      t.string :ownership_name
      t.string :ownership_sector
      t.string :ownership_form
      t.string :ownership_number
      
      t.string :institution_address_state
      t.string :institution_address_county
      t.string :institution_address_district
      t.string :institution_address_town
      t.string :institution_address_street
      t.string :institution_address_zip
      
      t.string :function_function
      t.string :function_share
      t.string :function_currency
      t.string :function_percent_share
      t.date :function_date_from
      t.date :function_date_to
      t.text :function_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :people, :user_id
  end
end
