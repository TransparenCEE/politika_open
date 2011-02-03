# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class Aktivity < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        return false unless @user
        item = find_embedded_item(:activities, hash)
        
        item.institution_name = hash[:ins_nazov]
        item.institution_sector = hash[:sektor_podnikania]
        item.institution_form = hash[:podnikatelska_forma]
        item.institution_nubmer = hash[:ins_ico]
        
        item.address_state = hash[:stat]
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        item.activity_information_activity = hash[:uca_nazov_pozicie]
        
        item.activity_information_date_from = \
          parse_date(hash[:uca_obdobie_od])
        item.activity_information_date_to = \
          parse_date(hash[:uca_obdobie_do])
        
        item.activity_information_is_honored = \
          parse_boolean(hash[:je_honorovana])
        item.activity_information_reward_currency = \
          parse_text(hash[:mena])
        item.activity_information_reward = \
          parse_text(hash[:vyska_honoraru])
        item.activity_information_notes = parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end
