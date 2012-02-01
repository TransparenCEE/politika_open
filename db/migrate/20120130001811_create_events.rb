class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :organisator_name
      t.string :organisator_sector
      t.string :organisator_form
      t.string :organisator_number
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.string :event_type
      t.string :event_purpose
      t.string :event_state
      t.string :event_town
      t.date :event_date_from
      t.date :event_date_to
      t.string :event_payed
      t.string :event_amount_currency
      t.string :event_amount
      t.text :event_notes

      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :events, :user_id
  end
end
