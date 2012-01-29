# -*- encoding : utf-8 -*-
class CompanyShare < ActiveRecord::Base
  include Forms::FormHelper  
  
  belongs_to :user
  
  def form_commercial
    !(["iné"].include?(basic_information_form))
  end
end
