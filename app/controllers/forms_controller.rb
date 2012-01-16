# -*- encoding : utf-8 -*-
class FormsController < ApplicationController
  
  before_filter :login_required
  before_filter :find_forms
  # before_filter :set_timestamp_recording, :only => :update
  
  def index
    
  end
  
  def show
    # Forms
    @finder = Forms::FormFinder.instance
    
    # User
    @user = current_user
    @form = @user.forms.find{|f|f.identifier.to_s == params[:id].to_s}
    raise "Can't find form with ID #{params[:id]}" unless @form
  end
  
  def update
    @user = current_user
    @form = @user.forms.find{|f|f.identifier.to_s == params[:id].to_s}
    @form.update(params[:user])
    @form.process
    if @form.valid?
      NotificationMailer.user_update(@user).deliver
      @user.save(:validate => false)
      flash[:notice] = "Zmeny boli uložené."
      redirect_to form_path(@form.identifier)
    else
      flash.now[:error] = "Prosím vyplnte správne všetky povinné položky formulára."
      render :action => "show"
    end
  end
  
  protected
  
  def find_forms
    @all_forms = current_user.visible_forms
  end
  
  def set_timestamp_recording
    User.record_timestamps = false if admin_presence?
  end
  
end
