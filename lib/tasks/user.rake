namespace :user do
  task :update => :environment do
    User.record_timestamps = false
    User.all.each do |user|
      puts "--> Saving user #{user.email} ..."
      user.save(:validate => false)
    end
  end
end