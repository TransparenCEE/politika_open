# encoding: utf-8

module Etl
  module Rules
    class VerejnyCinnitelFunkcia < Rule
      include Finder
      
      def process(hash)
        @user = find_user(hash)
        return false unless @user
        
        funkcia = @user.public_services.find_all { |p| p.etl_sid == hash[:sid] }.first
        unless funkcia
          puts "Creating new public service with SID #{hash[:sid]}"
          funkcia = @user.public_services.build(:etl_sid => hash[:sid])
        end
        
        funkcia.basic_information_service = hash[:fun_politicka_funkcia]
        funkcia.basic_information_from = \
          parse_year(hash[:fun_funkcne_obdobie_od])
        funkcia.basic_information_to = \
          parse_year(hash[:fun_funkcne_obdobie_do])
        funkcia.basic_information_candidate_for_party = \
          parse_text(hash[:fun_kandidoval_strana])
        
        @user.save(false)
      end
    end
  end
end