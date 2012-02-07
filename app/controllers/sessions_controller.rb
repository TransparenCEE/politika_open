# -*- encoding : utf-8 -*-

class SessionsController < ApplicationController
  
  before_filter :check_login, :except => [:destroy, :return]
  
  def new
    
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      log_in!(user)
      redirect_to user_path(user)
    else
      flash[:error] = "Neúspešne prihlásenie"
      render :action => "new"
    end
  end
  
  def destroy
    log_out!
    redirect_to root_path
  end
  
  def return
    if session[:admin_presence]
      managed = current_user
      manager = User.find(session[:admin_presence])
      session.delete(:admin_presence)
      log_in!(manager)
      redirect_to admin_user_path(managed)
    else
      flash[:error] = "Something evil just happened. ~)o"
      redirect_to root_path
    end
  end
  
  def reset_password
    if request.post?
      user = User.find_by_email(params[:email])
      if user.present? && (new_password = user.reset_password!).present?
        PasswordMailer.reset_password(user.email, new_password).deliver
        flash[:notice] = 'Na Vašu emailovú adresu bolo odoslané nové heslo.'
      else
        flash[:error] = 'Takúto e-mailovú adresu v projekte politikaopen neevidujeme.'
      end
      redirect_to root_url
    end
  end
  
  protected
  
  def check_login
    if logged_in?
      redirect_to root_path
    end
  end
  
end
