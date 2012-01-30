# -*- encoding : utf-8 -*-
class Sponsorship < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
  
  def sector_commercial
    !(["verejný", "iný"].include?(provider_sector))
  end
end
