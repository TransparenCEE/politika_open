class Forms::Fields::DateSelect < Forms::Fields::TextField
  
  def setup
    settings[:required_format] = /^\d{1,2}\.\s*\d{1,2}\.\s*\d{4}\s*/
  end
  
  def formatted_value
    date = super
    if date.is_a?(Date)
      format = settings[:date_format].to_sym if settings[:date_format]
      I18n.l(date, :format => format)
    else
      date
    end
  end
  
  def render
    options = settings[:html_options] || {}
    options.merge!({ "type" => "text", "name" => input_tag_name, "id" => input_tag_id, "value" => formatted_value })
    tag :input, options
  end
  
  def process
    new_value = nil
    new_value = Date.parse(value) unless value.blank?
    set_value_on_object(new_value)
  end
  
end