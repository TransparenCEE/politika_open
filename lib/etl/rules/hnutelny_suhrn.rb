# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class HnutelnySuhrn < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item_money = find_embedded_item(:money_properties, hash)
        item_other = find_embedded_item(:movable_properties, hash)
        
        item_money.basic_year = hash[:hnutelny_majetok_rok]
        item_money.basic_value = hash[:hnutelny_majetok_suhrna_hodnota]
        
        item_other.basic_year = hash[:hnutelny_majetok_rok]
        item_other.basic_movable_property = hash[:hnutelny_majetok_suhrn]
        
        @user.save(false)
      end
    end
  end
end
