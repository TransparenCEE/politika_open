# -*- encoding : utf-8 -*-
require "csv"

module Etl
  class Counters
    def initialize
      @path = ::File.join(Rails.root, "etl", "counters")
    end
    
    def method_missing(method_name, *args)
      get(method_name.to_s, *args)
    end
    
    def get(counter, id)
      file_path = ::File.join(@path, "#{counter}.csv")
      handler = ::File.open(file_path)
      header = CSV.parse_line(handler.readline, :col_sep => ',')
      lines = []
      until handler.eof?
        line = CSV.parse_line(handler.readline, :col_sep => ',')
        line_hash = {}
        header.size.times do |i|
          line_hash[header[i].to_sym] = line[i]
        end
        lines << line_hash
      end
      result = lines.find_all { |line| line[:sid].to_i == id.to_i }.first
      result ? result[:nazov] : nil
    end
  end
end
