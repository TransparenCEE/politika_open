# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class HnutelnyMajetok < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:other_properties, hash)
        
        item.basic_description = hash[:popis]
        item.basic_acquirement = @c.sposob_nadobudnutia(hash[:sposob_nadobudnutia])
        item.basic_acquirement_date = parse_year(hash[:rok_nadobudnutia])
        item.basic_sale_date = parse_year(hash[:rok_predaja])
        item.basic_acquirement_value = hash[:nadobudacia_hodnota]
        item.basic_currency = @c.mena(hash[:mena])
        item.basic_possesion_type = @c.typ_vlastnictva(hash[:typ_vlastnictva])
        item.basic_notes = hash[:poznamky]
        
        
        @user.save(false)
      end
    end
  end
end
