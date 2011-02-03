# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class Sponzorstvo < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:sponsorships, hash)
        
        item.provider_name = hash[:ins_nazov]
        item.provider_sector = \
          @c.sektor_podnikania(hash[:ins_sektor_podnikania])
        item.provider_form = \
          @c.podnikatelska_forma(hash[:ins_podnikatelska_forma])
        item.provider_number = parse_text(hash[:ins_ico])
        
        item.address_state = @c.stat(hash[:adr_stat])
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        item.sponsorship_sponsorship = hash[:spo_charakter]
        item.sponsorship_purpose = hash[:spo_ucel_podpory]
        item.sponsorship_date = parse_date(hash[:spo_datum])
        
        item.sponsorship_value = @c.honorar(hash[:spo_hodnota])
        item.sponsorship_value_currency = \
          @c.mena(hash[:spo_mena])
        item.address_notes = parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end
