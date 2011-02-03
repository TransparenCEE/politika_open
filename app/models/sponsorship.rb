# -*- encoding : utf-8 -*-
class Sponsorship
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :sponsorships
  
  def sector_commercial
    !(["verejný", "iný"].include?(provider_sector))
  end
  
end
