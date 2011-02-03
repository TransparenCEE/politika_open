# -*- encoding : utf-8 -*-
module Forms
  module Fields
    class CompanySector < DataSelect
      def setup
        settings[:data_source] = "company.sector" unless settings[:data_source]
      end
    end
  end
end
