# -*- encoding : utf-8 -*-
class Duty
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :duties
  
end
