# -*- encoding : utf-8 -*-
module Forms
  module Fields
    class District < DataSelect
      def setup
        settings[:data_source] = "geography.districts" unless settings[:data_source]
        settings[:grouped] = true unless settings[:grouped]
        settings[:prompt] = ""
        settings[:html_options] ||= Hash.new
        settings[:html_options][:class] = "bound"
        settings[:html_options][:"data-bound-to"] = "#{@form.object.class.name.downcase}_#{form.identifier}_county"
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
