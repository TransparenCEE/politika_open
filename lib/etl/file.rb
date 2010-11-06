module Etl
  class File
    attr_reader :name, :rule
    
    def initialize(path)
      @path = path
      @name = path.split('/').last.split('.').first
      @has_header = true
      capitalized_name = ActiveSupport::Inflector.camelize(@name)
      rule_class = ActiveSupport::Inflector.constantize("Etl::Rules::#{capitalized_name}")
      @rule = rule_class.new(self)
    end
    
    def process
      @file_handler = ::File.open(@path)
      if @has_header
        header = read_line
      end
      while line = read_line
        line_hash = {}
        header.size.times do |i|
          line_hash[header[i].to_sym] = line[i]
        end
        @rule.process(line_hash)
      end
    end
    
    def wipe
      @rule.wipe
    end
    
    def read_line
      return false if @file_handler.eof?
      line = @file_handler.readline
      CSV.parse_line(line, :col_sep => ',')
    end
  end
end