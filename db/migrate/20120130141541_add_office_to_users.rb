class AddOfficeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :offices_has_no_offices, :boolean
    add_column :users, :offices_nie_je_poslanec, :boolean
  end
end
