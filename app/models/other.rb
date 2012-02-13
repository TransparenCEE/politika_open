# -*- encoding : utf-8 -*-
class Other < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
