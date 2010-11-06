# encoding: utf-8

module Etl
  module Rules
    class VerejnyCinnitelPrislusnost < Rule
      include Finder
      
      def process(hash)
        @user = find_user(hash)
        return false unless @user
        
        strana = @user.parties.find_all { |p| p.etl_sid == hash[:sid] }.first
        unless strana
          puts "Creating new political party with SID #{hash[:sid]}"
          strana = @user.parties.build(:etl_sid => hash[:sid])
        end
        strana.basic_information_party = hash[:str_nazov]
        strana.basic_information_position = hash[:str_funkcia_strana]
        strana.basic_information_from = \
          parse_year(hash[:str_funkcne_obdobie_od])
        strana.basic_information_to = \
          parse_year(hash[:str_funkcne_obdobie_do])
        strana.basic_information_notes = \
          parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end