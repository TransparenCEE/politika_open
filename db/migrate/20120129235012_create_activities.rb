class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :institution_name
      t.string :institution_sector
      t.string :institution_form
      t.string :institution_nubmer
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.string :address_street
      t.string :address_zip
      
      t.boolean :activity_information_is_honored
      t.string :activity_information_activity
      t.string :activity_information_reward_currency
      t.string :activity_information_reward
      t.date :activity_information_date_from
      t.date :activity_information_date_to
      t.text :activity_information_notes
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :activities, :user_id
  end
end
