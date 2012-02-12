# -*- encoding : utf-8 -*-
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
    
    def disable_timestamp_recording
      User.record_timestamps = false
    end
    def enable_timestamp_recording
      User.record_timestamps = false
    end
  end
end
