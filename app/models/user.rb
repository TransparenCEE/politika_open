class User < ActiveRecord::Base
  include Forms::FormHelper
  
  has_many :parties
  has_many :public_services
  
  attr_accessor :password_changed
  
  validates_confirmation_of :password, if: :validate_password?, message: "should match confirmation"
  
  before_save :encode_password, :if => :password_changed
  def encode_password
    write_attribute(:password, Digest::SHA1.hexdigest(self.password.to_s))
  end

  def password=(new_password)
    if new_password.blank?
      return false
    else
      write_attribute(:password, new_password)
      @password_changed = true
    end
  end
  
  def validate_password?
    return true if new_record?
    @password_changed ? true : false
  end
  
  def self.authenticate(email, password)
    password = Digest::SHA1.hexdigest(password.to_s)
    user = self.first(:conditions => {:email => email, :password => password})
    user ? user : false
  end
  
  def is_published
    true
    # count_of_invalid_fields == 0
  end
  
  def name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end
  
  def full_name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end
end
