class Forms::Fields::TextArea < Forms::Field
  
  def render
    text_area_tag(input_tag_name, value)
  end
  
end