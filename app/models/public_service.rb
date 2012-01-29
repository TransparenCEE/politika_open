# -*- encoding : utf-8 -*-
class PublicService < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
