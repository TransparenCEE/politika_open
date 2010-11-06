namespace :etl do
  task :run => :environment do
    interface = Etl::Interface.new
    interface.run
  end

  task :wipe => :environment do
    interface = Etl::Interface.new
    interface.wipe
  end
end