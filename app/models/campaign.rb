# -*- encoding : utf-8 -*-
class Campaign < ActiveRecord::Base
  include Forms::FormHelper
  
  serialize :basic_expenses_type, Array
  
  belongs_to :user, touch: true
end
