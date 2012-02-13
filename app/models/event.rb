# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
  
  def sector_commercial
    !(["verejný", "iný"].include?(organisator_sector))
  end
end
