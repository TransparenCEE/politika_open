class RenameMeetingNotes < ActiveRecord::Migration
  def change
    rename_column :meetings, :basic_information_notes, :address_notes
  end
end
