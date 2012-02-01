class CreatePublicServices < ActiveRecord::Migration
  def change
    create_table :public_services do |t|
      t.string :basic_information_service
      t.date :basic_information_from
      t.date :basic_information_to
      t.string :basic_information_candidate_for_party
      t.string :basic_information_member_of
      t.text :basic_information_notes
      t.references :user, null: false
      
      t.integer :count_of_invalid_fields
      
      t.string :etl_sid

      t.timestamps
    end
    add_index :public_services, :user_id
  end
end
