class AddMeetingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetings_has_no_meetings, :boolean
    add_column :users, :meetings_not_presented, :boolean
  end
end
