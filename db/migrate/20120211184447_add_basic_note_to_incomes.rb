class AddBasicNoteToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :basic_note, :text

  end
end
