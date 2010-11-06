# encoding: utf-8

module Etl
  module Rules
    class ObchodnyPodiel < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        return false unless @user
        
        item = find_embedded_item(:company_shares, hash)

        item.basic_information_name = hash[:fir_nazov]
        item.basic_information_form = hash[:podnikatelska_forma]
        # item.basic_information_sector = hash[:sektor_podnikania]
        item.basic_information_number = hash[:fir_ico]
        item.basic_information_connected_to_public_sector = \
          parse_boolean(hash[:fir_je_verejny_sektor])
        item.address_state = case hash[:adr_stat]
        when 1
          "Slovensko"
        when 31
          "Česko"
        when 47
          "Francúzsko"
        when 5
          "Andorra"
        end
          
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        item.participation_position = hash[:ucast_pozicia_firma]
        item.participation_share = hash[:ucast_penazny_podiel]
        item.participation_currency = hash[:ucast_mena]
        item.participation_percent = hash[:ucast_percentuany_podiel]
        item.participation_date_from = parse_date(hash[:ucast_obdobie_od])
        item.participation_date_to = parse_date(hash[:ucast_obdobie_do])
        
        @user.save(false)
      end
    end
  end
end