class CreateColleagues < ActiveRecord::Migration
  def change
    create_table :colleagues do |t|
      t.string :form_function
      t.string :form_form
      t.date :form_date_from
      t.date :form_date_to
      
      t.boolean :information_no_approvement
      t.string :information_title
      t.string :information_name
      t.string :information_surname
      
      t.string :address_state
      t.string :address_county
      t.string :address_district
      t.string :address_town
      t.text :address_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :colleagues, :user_id
  end
end
