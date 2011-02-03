# -*- encoding : utf-8 -*-
class Income
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :incomes
  
end
