# -*- encoding : utf-8 -*-
class Meeting < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
