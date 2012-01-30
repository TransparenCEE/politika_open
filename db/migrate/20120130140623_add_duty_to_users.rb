class AddDutyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :duties_has_no_duties, :boolean
  end
end
