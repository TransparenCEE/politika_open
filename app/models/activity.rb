# -*- encoding : utf-8 -*-
class Activity
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :activities
  
  def updated_at
    super || nil
  end
  
  def sector_commercial
    !(["verejný", "iný"].include?(institution_sector))
  end
  
end
