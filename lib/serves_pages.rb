# -*- encoding : utf-8 -*-
module ServesPages
  def show
    path = path_for(params[:id])
    unless File.exists?(path)
      path = path_for("not_found")
    end
    
    @page = File.read(path)
    
    render :text => @page, :layout => true
  end
  
  protected
  
  def path_for(page)
    "#{Rails.root}/app/pages/#{page}.html"
  end
end
