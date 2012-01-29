class AddCompanySharesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_shares_not_owns_shares, :boolean
  end
end
