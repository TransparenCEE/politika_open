module Etl
  class Rule
    def initialize(file)
      @file = file
    end
    
    def parse_boolean(value)
      ["0", "false", false, nil].include?(value) ? false : true
    end
    
    def parse_date(value)
      begin
        Date.parse(value)
      rescue Exception => e
        puts "Can't parse date \"#{value}\". (#{e.message})"
        nil
      end
    end
    
    def parse_year(value)
      value.blank? ? nil : parse_date("#{value}-1-1")
    end
    
    def parse_text(value)
      value == "NULL" ? nil : value
    end
    
    def wipe
      
    end
  end
end