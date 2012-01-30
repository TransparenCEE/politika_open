class AddUnmovablePropertyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unmovable_property_no_properties, :boolean
  end
end
