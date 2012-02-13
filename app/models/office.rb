# -*- encoding : utf-8 -*-
class Office < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
  
  def sector_commercial
    !(["verejný", "iný"].include?(basic_sector))
  end
  
  def address_required
    basic_type == "Nehnuteľný majetok"
  end
end
