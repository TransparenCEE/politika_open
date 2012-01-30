class AddPersonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :persons_has_none, :boolean
    add_column :users, :persons_not_presented, :boolean
  end
end
