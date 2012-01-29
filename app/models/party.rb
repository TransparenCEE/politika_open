# -*- encoding : utf-8 -*-
class Party < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
