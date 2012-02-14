# -*- encoding : utf-8 -*-
class Colleague < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
