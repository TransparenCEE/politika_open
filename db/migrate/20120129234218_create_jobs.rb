class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :employer_name
      t.string :employer_sector
      t.string :employer_form
      t.string :employer_number
      t.string :employer_position
      t.date :employer_date_from
      t.date :employer_date_to
      
      t.string :employer_address_state
      t.string :employer_address_county
      t.string :employer_address_district
      t.string :employer_address_town
      t.string :employer_address_street
      t.string :employer_address_zip
      t.text :employer_address_notes
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :jobs, :user_id
  end
end
