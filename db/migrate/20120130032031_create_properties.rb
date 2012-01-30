class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :basic_description
      t.string :basic_acquirement
      t.boolean :basic_has_income
      t.string :basic_acreage
      t.string :basic_parcel_number
      t.string :basic_lv_number
      t.string :basic_acquirement_year
      t.string :basic_acquirement_value
      t.string :basic_acquirement_currency
      t.string :basic_year
      t.string :basic_market_value_estimate
      t.string :basic_market_value_estimate_currency
      t.string :basic_possesion_type
      t.string :basic_share
      t.date :basic_sale_date
      
      t.string :location_state
      t.string :location_county
      t.string :location_district
      t.string :location_town
      t.text :location_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :properties, :user_id
  end
end
