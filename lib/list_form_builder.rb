# -*- encoding : utf-8 -*-
class ListFormBuilder < ActionView::Helpers::FormBuilder
  
  %w{text_field select text_field_tag password_field text_area collection_select file_field check_box grouped_collection_select date_select}.each do |type|
    define_method type do |field, *args|
      options = args.extract_options!
      args = args + [options] unless options.empty?
      if options[:inline]
        super(field, *args)
      else
        classes = ["clearfix", "form_row"]
        field_for_label = field.to_s
        field_for_label = field_for_label.split('_').last if field_for_label =~ /^[a-z]{2}_/
        label_text = options[:label]
        label_text ||= field_for_label.to_s.capitalize
        required = options.delete(:required)
        if required
          label_text += ' *'
          classes << "required"
        end
        has_errors = options.delete(:has_errors)
        if has_errors
          classes << "errors"
        end
        if object && object.errors.include?(field.to_sym)
          classes << "errors"
        end
        @template.content_tag(:li, label(field, label_text) + super(field, *args) + options[:extra].to_s.html_safe, :class => classes.join(' '))
      end
    end
  end
  
  def locale_switcher *args
    @template.locale_switcher self, *args
  end
  
  def locale_tabs *args, &block
    @template.locale_tabs self, *args, &block
  end
  
  def field_required?(field_name)
    # object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end
end
