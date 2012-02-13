# -*- encoding : utf-8 -*-
class VehicleProperty < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user, touch: true
end
