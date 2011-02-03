# -*- encoding : utf-8 -*-
module Forms::MongoidDocument
  
  def self.included(base)
    base.extend(ClassMethods)
    base.send :cattr_accessor, :indexed_fields
    base.indexed_fields = []
    base.send :include, Mongoid::Timestamps
    base.field :count_of_invalid_fields, :type => Integer, :default => 0
    base.field :_keywords, :type => Array
    base.fields_from_forms
    
    base.before_save :count_invalid_fields
    base.after_save :save_user
    base.after_destroy :save_user
    base.before_save :index_fields
  end
  
  module ClassMethods
    
    def fields_from_forms
      # Get an instance of FormFinder
      form_finder = Forms::FormFinder.instance
      form_finder.forms_for(self).each do |form|
        form.fields.each do |field|
          data_type = field.settings[:data_type]
          if data_type
            type = "::#{field.settings[:data_type].capitalize}".constantize
          end
          self.field "#{form.identifier}_#{field.identifier}", :type => type
        end
        form.embeds.each do |embed|
          self.embeds_many embed.identifier
        end
      end
    end
    
    def index_field field
      self.indexed_fields << field.to_sym
    end
  end
  
  # Instance methods
  
  def forms
    form_finder = Forms::FormFinder.instance
    form_finder.forms_for(self)
  end
  
  def visible_forms
    forms.find_all do |form|
      form.visible_for?(self)
    end
  end
  
  def form
    form = forms.first
    form 
  end
  
  def value(form, field)
    self.send("#{form}_#{field}")
  end
  
  def boolean_value(form, field)
    val = self.value(form, field)
    if val.blank? || val == "0"
      false
    else
      true
    end
  end
  
  def identifier
    self.class.name.downcase
  end
  
  def embed_items(what)
    items = self.send(what)
    
    items.sort_by { |item|
      item.updated_at || 10.years.ago
    }.reverse
    
  end
  
  
  protected
  
  def count_invalid_fields
    count = 0
    self.visible_forms.each do |form|
      count += form.count_of_invalid_fields
    end
    self.count_of_invalid_fields = count
  end
  
  def save_user
    if self.respond_to?(:user) && self.user
      user.save
    end
  end
  
  def index_fields
    keywords = []
    self.class.indexed_fields.each do |field|
      data = self.send(field)
      data.to_s.split(' ').each do |el|
        keywords << el.downcase
      end
    end
    self._keywords = keywords
  end
  
end
