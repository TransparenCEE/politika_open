class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.string :provider_name
      t.string :provider_sector
      t.string :provider_form
      t.string :provider_number
      
      t.boolean :address_not_allowed_to_publish_information
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      t.text :address_notes
      
      t.string :sponsorship_sponsorship
      t.string :sponsorship_purpose
      t.date :sponsorship_date
      t.string :sponsorship_value_currency
      t.string :sponsorship_value
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :sponsorships, :user_id
  end
end
