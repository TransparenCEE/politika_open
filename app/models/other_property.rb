# -*- encoding : utf-8 -*-
class OtherProperty < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
