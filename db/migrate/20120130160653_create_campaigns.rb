class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :basic_election
      t.date :basic_date
      t.string :basic_physic_persons_gifts
      t.string :basic_physic_persons_gifts_currency
      t.string :basic_law_perosons_gifts
      t.string :basic_law_perosons_gifts_currency
      t.string :basic_own_money
      t.string :basic_own_money_currency
      t.string :basic_fulfillings
      t.string :basic_fulfillings_currency
      t.string :basic_fulfilling_type
      t.string :basic_expenses
      t.string :basic_expenses_currency
      t.text :basic_expenses_type
      t.string :basic_website
      t.date :basic_actualisation
      t.text :basic_notes
      
      t.references :user, null: false

      t.timestamps
    end
    add_index :campaigns, :user_id
  end
end
