# encoding: utf-8

module Etl
  module Rules
    class BlizkeOsoby < Rule
      include Finder
      
      def process(hash)        
        @user = find_user(hash)
        @c = Counters.new
        return false unless @user
        item = find_embedded_item(:persons, hash)
        
        item.basic_relation = parse_text(hash[:vztah_osoba])
        item.information_title = parse_text(hash[:titul])
        item.information_name = parse_text(hash[:meno])
        item.information_surname = parse_text(hash[:priezvisko])
        item.address_state = @c.stat(parse_text(hash[:adr_stat]))
        item.address_county = parse_text(hash[:adr_kraj])
        item.address_district = parse_text(hash[:adr_okres])
        item.address_town = parse_text(hash[:adr_obec])
        item.ownership_not_presented = \
          parse_boolean(parse_text(hash[:clenstvo_nechcem_uviest]))
        item.ownership_none = parse_boolean(parse_text(hash[:clenstvo_nema]))
        item.ownership_not_known = \
          parse_boolean(parse_text(hash[:clenstvo_nemam_vedomost]))
        item.ownership_name = parse_text(hash[:ins_nazov])
        item.ownership_sector = \
          @c.sektor_podnikania(parse_text(hash[:ins_sektor_podnikania]))
        item.ownership_form = \
          @c.podnikatelska_forma(parse_text(hash[:ins_podnikatelska_forma]))
        item.ownership_number = parse_text(hash[:ins_ico])
        item.institution_address_state = @c.stat(parse_text(hash[:adr_stat]))
        item.institution_address_county = parse_text(hash[:adr_kraj])
        item.institution_address_district = parse_text(hash[:adr_okres])
        item.institution_address_town = parse_text(hash[:adr_obec])
        item.institution_address_street = parse_text(hash[:adr_ul_cislo])
        item.institution_address_zip = parse_text(hash[:adr_psc])
        item.function_function = parse_text(hash[:ins_funkcia])
        item.function_share = parse_text(hash[:ins_penazny_podiel])
        item.function_currency = @c.mena(parse_text(hash[:ins_mena]))
        item.function_percent_share = parse_text(hash[:ins_percent_podiel])
        item.function_date_from = parse_year(parse_text(hash[:ins_obdobie_od]))
        item.function_date_to = parse_year(parse_text(hash[:ins_obdobie_do]))
        item.function_notes = parse_text(hash[:poznamky])
        
        @user.save(false)
      end
    end
  end
end