module Admin
  class ApplicationController < ::ApplicationController
    before_filter :admin_required
    
    protected
      
    def admin_required
      unless current_user && current_user.is_super_admin
        flash[:error] = "Táto sekcia vyžaduje administrátorské práva."
        return redirect_to forms_path
      end
    end
  end
end