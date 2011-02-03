# -*- encoding : utf-8 -*-
class PublicService
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :public_services
  
end
