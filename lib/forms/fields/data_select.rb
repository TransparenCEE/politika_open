# -*- encoding : utf-8 -*-
class Forms::Fields::DataSelect < Forms::Field
  
  def render
    result = ""
    data_finder = Forms::DataFinder.instance
    if settings[:data_source]
      data = data_finder.find_data(settings[:data_source])
    elsif
      data = settings[:data]
    else
      raise "Please set data with data or data_source keyword."
    end
    
    if !value.blank? && !data.collect{|d|d.to_s}.include?(value)
      result += text_field_tag(input_tag_name, value, settings[:html_options]||{})
    else
      if settings[:grouped]
        options = grouped_options_for_select(data, value, settings[:prompt]).html_safe
      else
        options = options_for_select(data, value)
      end
      
      result += select_tag(input_tag_name, options, settings[:html_options]||{})
    end
    
    if ["true", "1"].include?(settings[:allow_custom].to_s)
      result += %{ <br /><br /><a href="#" class="make-input" data-make-input="#{sanitize_to_id(input_tag_name)}" data-make-collection='#{data.to_json}'>všetky/iné</a><br /><br />}
    end
    
    result
  end
  
end
