class AddPoliticalPartyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :political_party_is_not_in_political_party, :boolean

  end
end
