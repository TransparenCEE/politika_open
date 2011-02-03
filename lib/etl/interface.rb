# -*- encoding : utf-8 -*-
module Etl
  class Interface
    def initialize
      @path = File.join(Rails.root, "etl", "data")
    end
    
    def files
      files = [ "uzivatel.csv",
                "verejny_cinnitel.csv",
                "verejny_cinnitel_prislusnost.csv",
                "verejny_cinnitel_funkcia.csv",
                "obchodny_podiel.csv",
                "zamestnanecka_pozicia.csv",
                "aktivity.csv",
                "funkcne_pozitky.csv",
                "sponzorstvo.csv",
                "pracovne_cesty_podujatia.csv",
                "suhrn_prijmov.csv",
                "nehnutelny_majetok.csv",
                "hnutelny_majetok.csv",
                "hnutelny_suhrn.csv",
                "hnutelny_auto.csv",
                "majetkove_prava.csv",
                "dolezite_stretnutia.csv",
                "blizke_osoby.csv" ]
      # Just the last one for now
      files = [files.last]
      files.collect do |file|
        file_path = ::File.join(@path, file)
        file = Etl::File.new(file_path)
      end
    end
    
    def run
      files.each do |file|
        file.process
      end
    end
    
    def wipe
      files.each do |file|
        file.wipe
      end
    end
  end
end
