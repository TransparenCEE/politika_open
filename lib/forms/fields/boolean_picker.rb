# -*- encoding : utf-8 -*-
module Forms
  module Fields
    class BooleanPicker < DataSelect
      def valid?
        true
      end

      def render
        options = options_for_select([[nil, nil], ['Áno', '1'], ['Nie', '0']], form_value)
        select_tag(input_tag_name, options, settings[:html_options]||{})
      end

      def process
        set_value_on_object(process_value)
      end

      def process_value
        value.blank? ? nil : (value == '1' ? true : false)
      end

      def form_value
        value.nil? ? nil : (value == true ? '1' : '0')
      end

      def formatted_value
        return 'Nevyplnené' if value.nil?
        value ? 'Áno' : 'Nie'
      end
    end
  end
end