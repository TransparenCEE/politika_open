# -*- encoding : utf-8 -*-
class Person
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :persons
  
end
