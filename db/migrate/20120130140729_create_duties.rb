class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.string :basic_description
      t.string :basic_acquirement_type
      t.string :basic_provider
      t.string :basic_possesion_type
      t.string :basic_share
      t.date :basic_acquirement_date
      t.date :basic_expiration_date
      
      t.string :value_total
      t.string :value_total_currency
      t.string :value_amount
      t.string :value_currency
      t.string :value_timeframe
      t.text :value_notes
      
      t.string :institution_title_or_name
      t.string :institution_sector
      t.string :institution_form
      t.string :institution_number
      t.boolean :institution_no_approvement
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :duties, :user_id
  end
end
