require "yaml"

class Forms::FormFinder
  
  include Singleton
  
  attr_reader :base_path, :model
  
  # Initializes Forms::FormFinder class and and loads all
  # forms from directory.
  def initialize
    @base_path = Forms::Config.instance.forms_directory
    @forms = {}
  end
  
  def forms_for(a_model)
    model_name = model_name_from_model(a_model)
    path = "#{@base_path}/#{model_name}.yml"
    @forms[model_name] = parse_file(path, a_model)
    forms = @forms[model_name]
    forms.sort_by{|form|form.order}
  end
  
  def form_for_with_identifier(a_model, an_identifier)
    forms = forms_for(a_model)
    forms.find_all { |form| form.identifier.to_s == an_identifier.to_s }.first
  end
  
  def embeds_for(a_model)
    forms = forms_for(a_model)
    embeds = forms.collect { |form| form.embeds }.flatten
  end
  
  def embed_for_with_identifier(a_model, an_identifier)
    embeds = embeds_for(a_model)
    embeds.find_all{ |embed| embed.identifier.to_s == an_identifier.to_s}.first
  end
  
  protected
  
  # Opens file at location, parses it builds array of forms.
  # File should conform to formatting rules.
  def parse_file(file, a_model = nil)
    begin
      document = YAML::load_file(file) 
    rescue
      raise "Can't open file #{file}"
    end
    
    raise "Too many root items." if document.size > 1
    
    root = document[document.keys.first]
    
    forms = []
    root.each do |form_identifier, form_settings|
      if a_model.is_a?(Class)
        form = Forms::Form.new(form_identifier)
      else
        form = Forms::Form.new(form_identifier, a_model)
      end
      form.attributes_from_hash(form_settings)
      forms << form
    end
    forms
  end
  
  def model_name_from_model(a_model)
    return a_model if a_model.is_a?(String)
    a_model = a_model.class unless a_model.is_a?(Class)
    return ActiveSupport::Inflector.underscore(a_model.to_s)
  end
  
end