# -*- encoding : utf-8 -*-
class Other
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :others

end
