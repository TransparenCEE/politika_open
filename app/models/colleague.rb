# -*- encoding : utf-8 -*-
class Colleague
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :colleague
  
end
