# -*- encoding : utf-8 -*-
class Job < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
  
  def sector_commercial
    !(["verejný", "iný"].include?(employer_sector))
  end
end
