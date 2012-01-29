class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :telephone_number
      t.boolean :is_active
      t.boolean :is_politician
      t.boolean :is_candidate
      t.integer :etl_sid
      t.integer :etl_verejny_cinnitel_sid
      t.boolean :is_super_admin
      t.boolean :is_accepting_rules
      
      t.string :basic_information_first_name
      t.string :basic_information_last_name
      t.date :basic_information_date_of_birth

      t.timestamps
    end
  end
end
