# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
