class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout "application"
    
  include Authentication
  
  # rescue_from Exception, :with => :general_error
  
  def general_error
    @page = File.read("#{Rails.root}/app/pages/error.html")
    render :text => @page, :layout => true
  end
  
  # By the way this is the coolest session name I ever
  # came up with. 
  def admin_presence?
    session[:admin_presence] ? true : false
  end
  
  protected
  
  def remember_referer
    session[:return_path] = request.referer
  end
  
  def saved_referer
    session[:return_path]
  end
  
end
