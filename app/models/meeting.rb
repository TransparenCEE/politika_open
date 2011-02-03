# -*- encoding : utf-8 -*-
class Meeting
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :meetings
  
end
