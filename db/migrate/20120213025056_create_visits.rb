class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :session_id
      t.references :user
      t.date :access_date

      t.timestamps
    end
    add_index :visits, [:session_id, :user_id, :access_date]
  end
end
