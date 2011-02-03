# -*- encoding : utf-8 -*-
require 'digest/sha1'
require 'RMagick'

class Forms::Fields::FileUpload < Forms::Field

  include Magick
  
  DESTROY_KEYWORD = 'destroy'
  
  def setup
    @form.multipart = true
  end
  
  def value=(what)
    if what == DESTROY_KEYWORD
      super(DESTROY_KEYWORD)
    elsif what.is_a? Tempfile
      @file = what
      @new_filename = Digest::SHA1.hexdigest(what.original_filename)
      @new_filename += ".#{what.original_filename.split('.').last}"
      super(@new_filename)
    end
  end
  
  def process
    # FIXME config upload path somewhere
    # raise @value.class.name
    if @value == DESTROY_KEYWORD
      original_filename = get_object_value
      path = path_for_filename(original_filename)
      if File.exists?(path)
        File.delete(path)
      end
      set_value_on_object(nil)
    else
      set_value_on_object(@value)
    end
    
    if @file
      path = path_for_filename(@new_filename)
      File.open(path, "wb") { |f| f.write(@file.read) }
      resize_file(path)
    end
  end
  
  def render
    result = file_field_tag(input_tag_name)
    if value
      result += content_tag :br
      result += link_to "Uložený súbor", "/uploads/#{value}"
      result += check_box_tag(input_tag_name, DESTROY_KEYWORD)
      result += "Odstranit"
    end
    result
  end
  
  protected
  
  def path_for_filename(name)
    "#{Rails.root}/public/uploads/#{name}"
  end
  
  def resize_file(path)
    image = Image.read(path).first
    image.change_geometry('300x1000') do |cols, rows, img| 
      img.resize!(cols, rows)
      img.write(path)
    end
  end
  
end
