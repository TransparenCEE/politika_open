class Job
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  embedded_in :user, :inverse_of => :jobs
  
  def sector_commercial
    !(["verejný", "iný"].include?(employer_sector))
  end
  
end