# -*- encoding : utf-8 -*-
class Property
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :properties
  
end
