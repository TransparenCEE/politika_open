module Forms
  module Fields
    class MultipleDataSelect < DataSelect
      def render
        result = '<div class="fl">'
        
        data_finder = Forms::DataFinder.instance
        data = data_finder.find_data(settings[:data_source])
        
        input_name = "#{input_tag_name}[]"
        
        data.each do |item|
          result += check_box_tag(input_name, item, self.value && self.value.include?(item.to_s))
          result += item
          result += "<br />"
        end
        
        result += '</div>'
        result
      end
      
      def formatted_value
        value.join(', ') if value
      end
    end
  end
end