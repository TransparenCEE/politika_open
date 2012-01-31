class AddCountOfInvalidFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_of_invalid_fields, :integer

  end
end
