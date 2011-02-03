# -*- encoding : utf-8 -*-
class Office
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :offices
  
  def sector_commercial
    !(["verejný", "iný"].include?(basic_sector))
  end
  
  def address_required
    basic_type == "Nehnuteľný majetok"
  end
end
