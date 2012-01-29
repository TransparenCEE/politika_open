module Forms::FormHelper
  
  
  def forms
    form_finder = Forms::FormFinder.instance
    form_finder.forms_for(self)
  end
  
  def visible_forms
    forms.find_all do |form|
      form.visible_for?(self)
    end
  end
  
  def value(form, field)
    self.send("#{form}_#{field}")
  end
end