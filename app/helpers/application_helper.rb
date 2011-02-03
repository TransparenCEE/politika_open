# -*- encoding : utf-8 -*-
module ApplicationHelper
  def uploaded_image(filename, *args)
    unless filename.blank?
      path = "/uploads/#{filename}"
      image_tag(path, *args)
    else
      image_tag('photo-placeholder.png')
    end
  end
  
  def button_link_to(what, where, *options)
    options = options.extract_options!
    klass = options[:class] ? options[:class] + " button" : "button"
    options[:class] = klass
    link_to "<span>#{h(what)}</span>".html_safe, where, options
  end
  
  def share_on_facebook(user)
    "http://www.facebook.com/sharer.php?u=%s&t=%s na Politika Open" % \
      [frontend_user_url(user), user.full_name]
  end
  
  def update_params(with)
    params.delete(:controller)
    params.delete(:action)
    params.merge(with)
  end
  
  def sort_link(text, column, direction = :asc)
    current_direction = params[:dir] ? params[:dir].to_sym : :asc
    if params[:sort] == column.to_s && params[:dir]
      new_direction = (current_direction == :asc ? :desc : :asc)
    else
      new_direction = direction
    end
    link_to text, update_params(:sort => column.to_s, :dir => new_direction)
  end
  
  def sort_direction_for_column(column)
    current_direction = params[:dir] ? params[:dir].to_sym : :asc
    if params[:sort].to_s == column.to_s
      params[:dir]
    end
  end
  
  def value_or_em(value, message)
    if value.present?
      value
    else
      "<em>#{message}</em>".html_safe
    end
  end
end
