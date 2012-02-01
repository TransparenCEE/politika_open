class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :provider_name
      t.string :provider_sector
      t.string :provider_form
      t.string :provider_number
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.string :benefit_description
      t.string :benefit_value
      t.string :benefit_value_currency
      t.date :benefit_date_from
      t.date :benefit_date_to
      t.text :benefit_notes
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :benefits, :user_id
  end
end
