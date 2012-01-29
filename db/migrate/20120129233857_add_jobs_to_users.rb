class AddJobsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :jobs_has_no_job, :boolean
  end
end
