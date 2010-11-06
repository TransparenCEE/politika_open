class Benefit
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :benefits
  
  def sector_commercial
    !(["verejný", "iný"].include?(provider_sector))
  end
  
end