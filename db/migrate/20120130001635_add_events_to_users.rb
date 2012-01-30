class AddEventsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :events_has_no_events, :boolean
    add_column :users, :events_events_not_expensive, :boolean
    add_column :users, :events_events_expensive, :boolean
  end
end
