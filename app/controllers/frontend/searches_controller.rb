# -*- encoding : utf-8 -*-
module Frontend
  class SearchesController < ApplicationController
    def new
      
    end
    
    def create
      redirect_to frontend_users_path(:search => params[:search][:name])
    end
  end
end
