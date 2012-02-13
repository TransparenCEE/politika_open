# -*- encoding : utf-8 -*-
class Activity < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
  
  def sector_commercial
    !(["verejný", "iný"].include?(institution_sector))
  end
end
