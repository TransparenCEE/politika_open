# -*- encoding : utf-8 -*-
class Candidature < ActiveRecord::Base
  include Forms::FormHelper
  
  belongs_to :user
end
