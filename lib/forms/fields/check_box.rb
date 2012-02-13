# -*- encoding : utf-8 -*-
class Forms::Fields::CheckBox < Forms::Field
  
  def render
    radio_button_checkbox = "radio_button_checkbox #{settings[:radio_button_checkbox]}" if settings[:radio_button_checkbox].present?

    result = hidden_field_tag(input_tag_name, "0")
    result += check_box_tag(input_tag_name, "1", value.present? && value == true, class: radio_button_checkbox )
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
