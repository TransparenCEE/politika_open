class AddActivitiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activities_has_no_activities, :boolean
  end
end
