class RenameAddressNotes < ActiveRecord::Migration
  def change
    rename_column :sponsorships, :address_notes, :sponsorship_notes
  end
end
