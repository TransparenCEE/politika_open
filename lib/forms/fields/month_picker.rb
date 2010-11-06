module Forms
  module Fields
    class MonthPicker < DateSelect
      def setup
        settings[:required_format] = nil
        settings[:date_format] = "month_and_year"
      end
      
      def render
        result = ""
        
        if value
          month = value[:month]
          year  = value[:year]
        else
          month, year = '', ''
        end
        
        
        months = (1..12).to_a.collect { |m|
          [I18n.t("date.month_names")[m], m]
        }.insert(0, '')
        month_options = options_for_select(months, month.to_i)
        month_select = select_tag("#{input_tag_name}[month]", month_options, :class => "medium")
        
        years = ((Date.today.year-10)..Date.today.year).to_a.reverse.insert(0, '')
        years << "---------"
        years.concat((1950..2050).to_a.reverse)
        year_options = options_for_select(years, year.to_i)
        year_select = select_tag("#{input_tag_name}[year]", year_options, :class => "medium")
        
        result += month_select
        result += year_select
        
        result
      end

      def process
        return if value.blank?
        if value[:month].blank? || value[:year].blank?
          set_value_on_object(nil)
        else
          date = Date.parse(formatted_value)
          set_value_on_object(date)
        end
      end
      
      def has_value?
        value && !value[:month].blank? && !value[:year].blank?
      end
      
      def value
        value = get_object_value
        if value.is_a?(Date)
          @value ||= {:month => value.month,
                      :year  => value.year}
        else
          @value ||= nil
        end
        @value
      end
      
      def formatted_value
        value ? "#{value[:month]}/#{value[:year]}" : ""
      end
      
    end
  end
end