# -*- encoding : utf-8 -*-
class Event
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :events
  
  def sector_commercial
    !(["verejný", "iný"].include?(organisator_sector))
  end
  
end
