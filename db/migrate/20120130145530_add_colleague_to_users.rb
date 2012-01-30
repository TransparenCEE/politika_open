class AddColleagueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :colleagues_has_none, :boolean
    add_column :users, :colleagues_not_presented, :boolean
  end
end
