# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class NehnutelnyMajetok < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:properties, hash)
        
        item.basic_description = \
          @c.popis_nehnutelnosti(hash[:uda_popis_nehnutelnosti])
        item.basic_acquirement = \
          @c.sposob_nadobudnutia(hash[:sposob_nadobudnutia])
        # item.basic_has_income = hash[:basic_has_income]
        item.basic_acreage = hash[:uda_vymera]
        item.basic_parcel_number = hash[:uda_cislo_parcely]
        item.basic_lv_number = hash[:uda_cislo_lv]
        item.basic_acquirement_year = hash[:uda_rok_nadobudnutia]
        item.basic_acquirement_value = hash[:uda_nadobudacia_hodnota]
        item.basic_acquirement_currency = @c.mena(hash[:uda_mena])
        item.basic_year = hash[:uda_trhova_hodnota_rok]
        item.basic_market_value_estimate = hash[:uda_trhova_hodnota_odhad]
        item.basic_market_value_estimate_currency = \
          @c.mena(hash[:uda_trhova_hodnota_mena])
        item.basic_possesion_type = \
          @c.typ_vlastnictva(hash[:uda_typ_vlastnictva])
        item.basic_share = hash[:uda_podiel]
        item.basic_sale_date = parse_date(hash[:uda_rok_predaja])
        
        item.location_state = @c.stat(hash[:adr_stat])
        item.location_county = hash[:adr_kraj]
        item.location_district = hash[:adr_okres]
        item.location_town = hash[:adr_obec]
        item.location_notes = hash[:poznamky]
        
        @user.save(false)
      end
    end
  end
end
