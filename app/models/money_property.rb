# -*- encoding : utf-8 -*-
class MoneyProperty
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :money_properties
  
end
