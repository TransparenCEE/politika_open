# -*- encoding : utf-8 -*-
class Income < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
