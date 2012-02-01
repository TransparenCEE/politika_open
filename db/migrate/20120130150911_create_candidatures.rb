class CreateCandidatures < ActiveRecord::Migration
  def change
    create_table :candidatures do |t|
      t.string :basic_election
      t.date :basic_date
      t.string :basic_function
      t.string :basic_candidated_for
      t.string :basic_candidated_for_town
      t.text :basic_note
      
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :candidatures, :user_id
  end
end
