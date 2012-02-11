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
  
  def embed_items(what, sort_attribute = nil)
    items = self.send(what)
    
    items.sort_by { |item|
      if sort_attribute.present?
        item.send(sort_attribute)
      else
        item.updated_at || 10.years.ago
      end
    }.reverse
  end
end