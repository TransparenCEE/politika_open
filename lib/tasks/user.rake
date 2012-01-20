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
  
  task something: :environment do
    old_db_users = User.all.map{|u| u}
    
    Mongoid.master = Mongo::Connection.new("localhost").db("politikaopen_production2")
    User._collection = Mongoid::Collection.new User, 'users' 
    
    new_db_users = User.all.map{|u| u}
    
    embeds = Forms::FormFinder.instance.embeds_for(User).map(&:identifier)
    old_bad_news = []
    
    old_db_users.each do |old_db_user|
      new_user_match = new_db_users.find{|u| u.id == old_db_user.id}
      if new_user_match.present?
        old_embed_ids = embeds.map{ |embed| old_db_user.send(embed).map(&:id) }
        new_embed_ids = embeds.map{ |embed| new_user_match.send(embed).map(&:id) }
        if (old_embed_ids.flatten - new_embed_ids.flatten).present?
          puts "User: #{new_user_match.basic_information_first_name} #{new_user_match.basic_information_last_name}\nID:#{new_user_match.id}\nHas embed ids in the old db that are not present in the new db!"
          puts
          puts "old_embed_ids: #{old_embed_ids.inspect}"
          puts
          puts "new_embed_ids: #{new_embed_ids.inspect}"
          puts
          puts "old_embed_ids - new_embed_ids(embed ids in the old db that are not present in the new db): #{(old_embed_ids.flatten - new_embed_ids.flatten).inspect}"
          old_bad_news << "#{new_user_match.basic_information_first_name} #{new_user_match.basic_information_last_name}"
        else
          puts "User: #{new_user_match.basic_information_first_name} #{new_user_match.basic_information_last_name}\nID:#{new_user_match.id}\nHas the same ids of embeds in both dbs!"
        end
      else
        puts "User: #{old_db_user.basic_information_first_name} #{old_db_user.basic_information_last_name}\nID:#{old_db_user.id}\nIs present in the old db and not present in the new db!"
      end
      puts '-----'
      puts
    end
    puts old_bad_news.length
    puts old_bad_news.inspect
  end
end