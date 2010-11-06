module Forms
  module Fields
    class County < DataSelect
      def setup
        settings[:data_source] = "geography.counties" unless settings[:data_source]
      end
      
      def required?
        return false unless super
        begin
          state_value = object.send("#{form.identifier}_state")
          if state_value == "Slovensko" || (object.new_record? && state_value.blank?)
            true
          else
            false
          end
        rescue
          true
        end
      end
    end
  end
end