# -*- encoding : utf-8 -*-
class Forms::Field

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper

  attr_accessor :identifier, :settings, :form, :type

  # Factory method for quickly building field with identifier, type and
  # settings.
  def self.field_with_identifier_type_settings(identifier, type, settings = nil)
    class_name = "Forms::Fields::#{ActiveSupport::Inflector.camelize(type)}"
    klass = ActiveSupport::Inflector.constantize(class_name)
    klass.new(identifier, settings)
  end

  # Initializer method.
  def initialize(identifier, settings = nil)
    @identifier = identifier.to_s
    @settings = {}
    settings ||= Hash.new
    settings.each do |k, v|
      @settings[k.to_sym] = v
    end
    @type = @settings[:type] || "text_field"
  end

  # Returns title if specified, otherwise somewhat humanized identifier.
  def title
    @settings[:title] || @identifier.gsub('_', ' ').capitalize
  end

  # Label = title
  alias_method :label, :title

  # Tries to guess if value in settings/required says true
  def required?
    if settings[:required_if]
      return true if object.send(settings[:required_if])
    end

    if settings[:required_unless]
      return true unless object.send(settings[:required_unless])
    end

    if ["1", "true", 1, true].include?(settings[:required])
      true
    else
      false
    end
  end

  # Returns true if field is valid. For now it only checks required, but
  # there might be more complicated validators in the future. If so, this
  # method will need some tune up.
  def valid?
    if self.required? && !has_value?
      return false
    end
    if !value.blank? && !format_valid?
      return false
    end
    true
  end

  def has_value?
    !value.blank?
  end

  def format_valid?
    if settings[:required_format].is_a?(Regexp)
      regexp = settings[:required_format]
    elsif settings[:required_format].is_a?(String)
      regexp = Regexp.new(settings[:required_format])
    end
    if regexp && !(value =~ regexp)
      return false
    else
      return true
    end
  end

  # Field might not be valid, but it has errors only in the case when it's
  # being validated and it is not valid. This is for user interface, for
  # coloring some fields as red.
  def has_errors?
    form.is_being_validated ? !valid? : false
  end

  # Renders field
  def to_s
    render
  end

  # Method for setting up something extra with the field. This is empty here
  # because this is kind of abstract class.
  def setup

  end

  # Method that is called when form is processed. Useful for some hooks while
  # processing.
  def process
    set_value_on_object(value)
  end

  # Render method, for this abstract class it returns Not Implemented.
  def render
    "Not implemented"
  end

  def input_tag_name
    "#{@form.object.class.name.downcase}[#{identifier_with_form}]"
  end

  def input_tag_id
    "#{@form.object.class.name.downcase}_#{identifier_with_form}"
  end

  def identifier_with_form
    "#{@form.identifier}_#{self.identifier}"
  end

  def object
    @form.object
  end

  def value
    @value ||= get_object_value
  end

  def value=(new_value)
    @value = new_value
  end

  def get_object_value
    begin
      @form.object.send(identifier_with_form)
    rescue
      nil
    end
  end

  def set_value_on_object(value)
    puts "Saving value: #{value.to_yaml}"
    @form.object.send("#{identifier_with_form}=", value)
  end

  def formatted_value
    if settings[:format] == "website"
      escaped_value = CGI.escapeHTML(value)
      if escaped_value =~ /^http:\/\//
        link = escaped_value
      else
        link = "http://#{escaped_value}"
      end
      title = link.sub('http://', '')
      ('<a href="%s">%s</a>' % [link, title]).html_safe
    elsif settings[:format] == "email"
      escaped_value = CGI.escapeHTML(value)
      ('<a href="mailto:%s">%s</a>' % [escaped_value, escaped_value]).html_safe
    else
      value
    end
  end

  def is_filled?
    !value.blank?
  end

  def html_classes
    classes = []
    classes << "required" if required?
    classes << "errors" if has_errors?
    classes.join(' ')
  end

end
