# encoding: utf-8

module Etl
  module Rules
    class VerejnyCinnitel < Rule
      def process(hash)
        user = User.where(:etl_sid => hash[:uzivatel_sid].to_i).execute.first
        unless user
          puts "(verejny cinnitel) Can't find user with SID = #{hash[:uzivatel_sid]}. Skipping operations."
          return false
        end
        
        # Meta
        user.etl_verejny_cinnitel_sid = hash[:sid].to_i
        user.is_active = parse_boolean(hash[:je_aktivny])
        
        # Basic information
        user.basic_information_title = hash[:title]
        user.basic_information_first_name = hash[:meno]
        user.basic_information_last_name = hash[:priezvisko]
        user.basic_information_birth_last_name = hash[:priezvisko]
        user.basic_information_county = hash[:adr_kraj]
        user.basic_information_district = hash[:adr_okres]
        user.basic_information_address_city = hash[:adr_obec]
        user.basic_information_address_address = \
          hash[:adr_ul_cislo]
        user.basic_information_address_zipcode = hash[:adr_psc]
        user.basic_information_date_of_birth = \
          parse_date(hash[:dat_narodenia])
        user.basic_information_note = hash[:poznamky]
        
        # Zamestnanie
        user.jobs_has_no_job = parse_boolean(hash[:nemam_zamestnanie])
        
        # Blizke osoby
        user.persons_has_none = parse_boolean(hash[:osoby_nemam])
        user.persons_not_presented = \
          parse_boolean(hash[:osoby_nechcem_uviest])
          
        # Aktivity
        user.activities_has_no_activities = \
          parse_boolean(hash[:nezastavam_aktivitu])
        
        # Hnutelny majetok
        user.movable_property_has_no_other_property = \
          parse_boolean(hash[:nevlastnim_hnutelny_majetok])
        user.movable_property_has_no_vehicle_property = \
          parse_boolean(hash[:nevlastnim_auto])
          
        # Nehnutelny majetok
        user.unmovable_property_no_properties = \
          parse_boolean(hash[:nevlastnim_nehnutelny_majetok])
          
        # Spolupracovnici
        user.colleagues_has_none = \
          parse_boolean(hash[:spolupracovnici_nemam])
        user.colleagues_not_presented = \
          parse_boolean(hash[:spolupracovnici_nechcem_uviest])
        
        # Vyhody
        user.benefits_has_no_benefits = \
          parse_boolean(hash[:nemam_funkcne_pozitky])
          
        # Majetkove prava
        user.duties_has_no_duties = \
          parse_boolean(hash[:nevlastnim_majetkove_prava])
        
        # Sponzorstvo
        user.sponsorships_has_no_sponsorships = \
          parse_boolean(hash[:neprijal_sponzorstvo])
          
        # Stretnutia
        user.meetings_has_no_meetings = \
          parse_boolean(hash[:stretnutie_nezucastnil])
        user.meetings_not_presented = \
          parse_boolean(hash[:stretnutie_nechcem_uviest])
          
        # Pracovne cesty
        case hash[:switch_pracovne_cesty]
          when "1"
            user.events_has_no_events = true
          when "2"
            user.events_events_not_expensive = true
          when "3"
            user.events_events_expensive = true
        end
        
        # Obchodne podiely
        user.company_shares_not_owns_shares = \
          parse_boolean(hash[:nevlastnim_obchodne_podiely])
        
        user.save(false)
      end
    end
  end
end