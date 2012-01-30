class AddCampaignToUsers < ActiveRecord::Migration
  def change
    add_column :users, :campaigns_has_none, :boolean
    add_column :users, :campaigns_not_presented, :boolean
  end
end
