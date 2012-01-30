class CreateMovableProperties < ActiveRecord::Migration
  def change
    create_table :movable_properties do |t|
      t.string :basic_year
      t.string :basic_movable_property
      t.string :basic_currency
      t.text :basic_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :movable_properties, :user_id
  end
end
