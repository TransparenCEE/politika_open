class AddCachedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cached_current_party, :string
    add_column :users, :cached_candidature_party, :string
    add_column :users, :cached_candidature_election, :string
    add_column :users, :cached_candidature_function, :string
    add_column :users, :cached_candidature_town, :string
  end
end
