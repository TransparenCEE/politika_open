# -*- encoding : utf-8 -*-
class OtherProperty
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :other_properties
  
end
