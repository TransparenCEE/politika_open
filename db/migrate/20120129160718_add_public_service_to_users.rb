class AddPublicServiceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_service_is_not_in_public_service, :boolean
  end
end
