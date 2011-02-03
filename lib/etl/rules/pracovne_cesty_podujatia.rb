# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class PracovneCestyPodujatia < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:events, hash)
        
        item.organisator_name = hash[:ins_nazov]
        item.organisator_sector = \
          @c.sektor_podnikania(hash[:ins_sektor_podnikania])
        item.organisator_form = \
          @c.podnikatelska_forma(hash[:ins_podnikatelska_forma])
        item.organisator_number = parse_text(hash[:ins_ico])
        
        item.address_state = @c.stat(hash[:adr_stat])
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        item.event_type = hash[:cha_charakter_udalosti]
        item.event_purpose = hash[:cha_ucel_udalosti]
        item.event_state = @c.stat(hash[:cha_destinacia_stat])
        item.event_town = hash[:cha_destinacia_mesto]
        item.event_date_from = parse_date(hash[:cha_obdobie_od])
        item.event_date_to = parse_date(hash[:cha_obdobie_do])
        item.event_payed = parse_text(hash[:cha_hradene_bolo])
        item.event_amount = @c.uhrada(hash[:cha_vyska_uhrady])
        item.event_amount_currency = @c.mena(hash[:cha_mena])
        item.event_notes = parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end
