# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  # include ServesPages
  
  def show
    render params[:id]
  end
end
