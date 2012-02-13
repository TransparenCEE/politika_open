# -*- encoding : utf-8 -*-
class Property < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
