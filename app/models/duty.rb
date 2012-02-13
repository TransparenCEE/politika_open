# -*- encoding : utf-8 -*-
class Duty < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
