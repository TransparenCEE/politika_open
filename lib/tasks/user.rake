namespace :user do
  task :update => :environment do
    User.record_timestamps = false
    User.all.each do |user|
      puts "--> Saving user #{user.email} ..."
      begin
        user.save(:validate => false)
      rescue Exception => e
        puts "! Failed to save user #{user.email}."
        puts "  (#{e.message})"
      end
    end
  end
end