# -*- encoding : utf-8 -*-
class MoneyProperty < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
