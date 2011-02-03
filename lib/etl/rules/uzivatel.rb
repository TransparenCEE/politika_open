# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class Uzivatel < Rule
      def process(hash)
        user = User.where(:etl_sid => hash[:sid].to_i).execute.first
        unless user
          puts "Creating new user for SID #{hash[:sid]}"
          user = User.new
        end
        user.etl_sid = hash[:sid].to_i
        user.email = hash[:logns]
        user.password = hash[:heslo]
        unless hash[:meno].blank?
          meno = hash[:meno].split(/\s+/)
          user.basic_information_first_name = meno[0]
          user.basic_information_last_name  = meno[1]
        end
        user.is_politician = true
        user.save(false)
      end
      
      def wipe
        User.delete_all
      end
    end
  end
end
