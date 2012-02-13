class RenameDutiesNotes < ActiveRecord::Migration
  def change
    rename_column :duties, :value_notes, :address_notes
  end
end
