# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class MajetkovePrava < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:duties, hash)
        
        item.basic_description = @c.majetok_popis(hash[:popis])
        item.basic_acquirement_type = \
          @c.majetok_sposob_nadobudnutia(hash[:sposob_nadobudnutia])
        # item.basic_provider = hash[:basic_provider]
        item.basic_possesion_type = \
          @c.majetok_typ_vlastnictva(hash[:typ_vlastnictva])
        # item.basic_share = hash[:basic_share]
        item.basic_acquirement_date = \
          parse_year(hash[:rok_nadobudnutia])
        item.basic_expiration_date = parse_year(hash[:rok_zaniku])
        # item.value_total = hash[:value_total]
        item.value_amount = hash[:suma]
        item.value_currency = @c.mena(hash[:mena])
        item.value_timeframe = hash[:obdobie]
        item.value_notes = hash[:poznamky]        
        
        @user.save(false)
      end
    end
  end
end
