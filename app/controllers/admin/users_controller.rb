# -*- encoding : utf-8 -*-
module Admin
  class UsersController < ApplicationController
    include Sorting

    # before_filter :set_timestamp_recording, :only => [:update, :activate, :reset]
    
    def index
      @page = params[:page] ? params[:page].to_i : 1
      @per_page = 20
      
      if params[:keyword].present?
        @users = User.search(params[:keyword], star: true, order: sort_by, sort_mode: sort_direction, page: @page, per_page: @per_page)
      else
        @users = User.page(@page).per(@per_page)
      end
      
      @pages = (User.count.to_f / @per_page.to_f).ceil
    end
    
    def activate
      @user = User.find(params[:id])
      @user.is_active = true
      @user.save(:validate => false)
      flash[:notice] = "Používateľ #{@user.email} bol aktivovaný."
      redirect_to :back
    end
    
    def show
      redirect_to edit_admin_user_path(params[:id])
    end
    
    def edit
      remember_referer
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.attributes = params[:user]
      @user.save(:validate => false)
      flash[:notice] = "Nastavenia boli uložené"
      
      path = admin_user_path(@user)
      redirect_to(saved_referer || path)
    end
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Používateľ #{@user.email} bol vymazaný."
      redirect_to admin_users_path
    end
    
    def reset
      @user = User.find(params[:id])
      @new_password = SecureRandom.base64(6)
      @user.password = @new_password
      @user.save(:validate => false)
    end
    
    def login
      @user = User.find(params[:id])
      session[:admin_presence] = current_user._id
      log_in!(@user)
      flash[:notice] = "Boli ste odhlásený a prihlásený ako #{@user.email}."
      redirect_to forms_path
    end
    
    protected
   
    def set_timestamp_recording
      User.record_timestamps = false
    end
    
  end
end
