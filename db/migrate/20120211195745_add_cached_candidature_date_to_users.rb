class AddCachedCandidatureDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cached_candidature_date, :date

  end
end
