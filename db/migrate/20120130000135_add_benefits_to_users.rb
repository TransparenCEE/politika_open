class AddBenefitsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :benefits_has_no_benefits, :boolean
  end
end
