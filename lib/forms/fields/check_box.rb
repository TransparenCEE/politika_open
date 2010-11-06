class Forms::Fields::CheckBox < Forms::Field
  
  def render
    result = hidden_field_tag(input_tag_name, "0")
    result += check_box_tag(input_tag_name, "1", value)
    result
  end
  
  def formatted_value
    v = self.value
    if value
      "Áno"
    else
      "Nie"
    end
  end
  
end