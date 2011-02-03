# -*- encoding : utf-8 -*-
class Candidature
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :candidatures
  
end
