# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  
  before_filter :login_required, :only => [:update, :show]
  
  def new
    @user = User.new
  end
  
  def create
    begin
      @user = User.new(params[:user])
      @user.is_active = false
      success = @user.save
    rescue
      success = false
    end
    if success
      NotificationMailer.user_update(@user, true).deliver
      log_in!(@user)
      redirect_to user_path(@user)
    else
      render :action => "new"
    end
  end
  
  def show
    @user = current_user
  end
  
  def update
    @user = current_user
    params.delete(:is_super_admin)
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Nastavenia boli uložené"
      redirect_to forms_path
    else
      render :action => "show"
    end
  end
  
  def print
    respond_to do |wants|
      wants.pdf do
        pdf = AffidavitPdf.new(current_user)
        send_data pdf.render, filename: 'cestne_prehlasenie.pdf',
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end
  
end 
