class CreateVehicleProperties < ActiveRecord::Migration
  def change
    create_table :vehicle_properties do |t|
      t.string :basic_brand
      t.string :basic_model
      t.string :basic_year
      t.string :basic_acquirement
      t.date :basic_acquirement_date
      t.date :basic_sale_date
      t.string :basic_acquirement_value
      t.string :basic_currency
      t.string :basic_possesion_type
      t.string :basic_share
      t.string :basic_mileage
      t.text :basic_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :vehicle_properties, :user_id
  end
end
