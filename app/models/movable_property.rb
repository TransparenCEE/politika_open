# -*- encoding : utf-8 -*-
class MovableProperty < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
