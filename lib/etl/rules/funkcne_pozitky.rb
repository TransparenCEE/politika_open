# encoding: utf-8

module Etl
  module Rules
    class FunkcnePozitky < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        return false unless @user
        item = find_embedded_item(:benefits, hash)
        
        item.provider_name = hash[:uda_nazov]
        item.provider_sector = parse_text(hash[:sektor_podnikania])
        item.provider_form = parse_text(hash[:podnikatelska_forma])
        item.provider_number = parse_text(hash[:uda_ico])
        
        item.address_state = hash[:stat]
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        item.benefit_description = \
          hash[:cha_popis_funkcneho_pozitku]
        item.benefit_value = \
          hash[:cha_vyjadrenie_hodnoty_pozitku]
        item.benefit_date_from = parse_date(hash[:cha_obdobie_od])
        item.benefit_date_to = parse_date(hash[:cha_obdobie_do])
        item.benefit_notes = parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end