class CreateCompanyShares < ActiveRecord::Migration
  def change
    create_table :company_shares do |t|
      t.string :basic_information_name
      t.string :basic_information_form
      t.string :basic_information_number
      t.boolean :basic_information_connected_to_public_sector
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.string :participation_position
      t.string :participation_share
      t.string :participation_currency
      t.string :participation_percent
      t.date :participation_date_from
      t.date :participation_date_to
      t.text :participation_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :company_shares, :user_id
  end
end
