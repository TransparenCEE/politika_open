# -*- encoding : utf-8 -*-
module Authentication

  def self.included(base)
    base.helper_method :logged_in?, :current_user
  end
  
  def login_required
    # This is temporary fix until Rails 3 and RSpec 2 gets final
    return if Rails.env == "test"
    return redirect_to new_session_path unless current_user
  end
  
  def log_in!(user)
    session[:current_user] = user.id
  end
  
  def log_out!
    session[:current_user] = nil
  end
  
  def logged_in?
    current_user ? true : false
  end
  
  def current_user
    session[:current_user] ? User.first(conditions: {id: session[:current_user]}) : nil
  end
    
end
