class Forms::Config
  
  include Singleton
  
  attr_accessor :forms_directory, :data_directory
  
  def initialize
    @forms_directory = "#{Rails.root}/app/forms"
    @data_directory = "#{Rails.root}/app/data"
  end
  
end