class CreateOthers < ActiveRecord::Migration
  def change
    create_table :others do |t|
      t.text :basic_content
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :others, :user_id
  end
end
