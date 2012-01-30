class AddMovablePropertyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :movable_property_has_no_vehicle_property, :boolean
    add_column :users, :movable_property_has_no_other_property, :boolean
  end
end
