class AddSponsorshipsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sponsorships_has_no_sponsorships, :boolean
  end
end
