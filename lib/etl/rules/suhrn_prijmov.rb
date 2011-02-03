# -*- encoding : utf-8 -*-

module Etl
  module Rules
    class SuhrnPrijmov < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:incomes, hash)
        
        item.basic_year = hash[:rok]
        item.basic_amount_main = hash[:vyska_prijmu]
        item.basic_currency_main = @c.mena(hash[:mena])
        
        
        @user.save(false)
      end
    end
  end
end
