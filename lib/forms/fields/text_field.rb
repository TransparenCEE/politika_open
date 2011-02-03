# -*- encoding : utf-8 -*-
class Forms::Fields::TextField < Forms::Field
  
  def render
    options = settings[:html_options] || {}
    options.merge!({ "type" => "text", "name" => input_tag_name, "id" => input_tag_id, "value" => value })
    tag :input, options
  end
  
end
