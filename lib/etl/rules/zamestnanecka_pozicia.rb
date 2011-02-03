# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class ZamestnaneckaPozicia < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        return false unless @user
        
        item = find_embedded_item(:jobs, hash)

        item.employer_name    = hash[:zam_nazov]
        item.employer_sector  = hash[:sektor_podnikania] 
        item.employer_form    = parse_text(hash[:podnikatelska_forma])
        item.employer_number  = hash[:zam_ico]
        
        item.employer_date_from = parse_date(hash[:zam_obdobie_od])
        item.employer_date_to   = parse_date(hash[:zam_obdobie_do])
        
        item.employer_address_state = hash[:stat]
        item.employer_address_county = hash[:adr_kraj]
        item.employer_address_district = hash[:adr_okres]
        item.employer_address_town = hash[:adr_obec]
        item.employer_address_street = hash[:adr_ul_cislo]
        item.employer_address_zip = hash[:adr_psc]
        item.employer_address_notes = hash[:poznamky]
        
        @user.save(false)
      end
    end
  end
end
