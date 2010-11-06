# encoding: utf-8

module Etl
  module Rules
    class DoleziteStretnutia < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:meetings, hash)
        
        item.basic_information_type = hash[:cha_charakter_stretnutia]
        item.basic_information_purpose = hash[:cha_ucel_stretnutia]
        item.basic_information_state = hash[:cha_destinacia_stat]
        item.basic_information_town = hash[:cha_destinacia_mesto]
        item.basic_information_date_from = parse_date(hash[:cha_obdobie_od])
        item.basic_information_date_to = parse_date(hash[:cha_obdobie_do])
        item.basic_information_payed = hash[:cha_hradene_bolo]
        item.basic_information_amount = hash[:cha_vyska_uhrady]
        item.basic_information_currency = @c.mena(hash[:cha_mena])
        item.basic_information_notes = hash[:poznamky]
        item.institution_title_or_name = hash[:uda_nazov]
        item.institution_sector = \
          @c.sektor_podnikania(hash[:uda_sektor_podnikania])
        item.institution_form = \
          @c.podnikatelska_forma(hash[:uda_podnikatelska_forma])
        item.institution_number = hash[:uda_ico]
        # item.institution_no_approvement = hash[:institution_no_approvement]
        item.institution_title = hash[:uda_titul]
        item.institution_name = hash[:uda_meno]
        item.institution_surname = hash[:uda_priezvisko]
        item.address_state = @c.stat(hash[:adr_stat])
        item.address_county = hash[:adr_kraj]
        item.address_district = hash[:adr_okres]
        item.address_town = hash[:adr_obec]
        item.address_street = hash[:adr_ul_cislo]
        item.address_zip = hash[:adr_psc]
        
        
        @user.save(false)
      end
    end
  end
end