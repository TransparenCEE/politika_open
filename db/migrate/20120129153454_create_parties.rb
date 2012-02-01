class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :basic_information_party
      t.text :basic_information_position
      t.date :basic_information_from
      t.date :basic_information_to
      t.text :basic_information_notes
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    
    add_index :parties, :user_id
  end
end
