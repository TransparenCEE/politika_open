# -*- encoding : utf-8 -*-
class Benefit < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
  
  def sector_commercial
    !(["verejný", "iný"].include?(provider_sector))
  end
end
