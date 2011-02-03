# -*- encoding : utf-8 -*-
class Party
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :parties
  
end
