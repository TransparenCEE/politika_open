# -*- encoding : utf-8 -*-
module Forms
  module Fields
    class State < DataSelect
      def setup
        settings[:data_source] = "geography.states" unless settings[:data_source]
      end
    end
  end
end
