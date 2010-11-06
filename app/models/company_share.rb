class CompanyShare
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :company_shares

  def form_commercial
    !(["iné"].include?(basic_information_form))
  end
  
end