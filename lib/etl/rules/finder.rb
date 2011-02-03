# -*- encoding : utf-8 -*-

module Etl
  module Rules
    module Finder
      def find_user(hash)
        user = User.where({:etl_sid => hash[:uzivatel_sid].to_i, :etl_verejny_cinnitel_sid => hash[:verejny_cinnitel_sid].to_i}).execute.first
        unless user
          puts "(#{self.class.name}) Can't find user with SID = #{hash[:uzivatel_sid]} and VEREJNY_CINNITEL_SID = #{hash[:verejny_cinnitel_sid]}. Skipping operations."
          return false
        else
          user
        end
      end
      
      def find_embedded_item(relation, hash)
        item = @user.send(relation).find_all { |i| i.etl_sid == hash[:sid] }.first
        unless item
          item = @user.send(relation).build(:etl_sid => hash[:sid])
          puts "Creating new #{item.class.name} share with SID #{hash[:sid]}"
        end
        
        item
      end
    end
  end
end
