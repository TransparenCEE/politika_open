# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  include Forms::FormHelper
  
  has_many :parties
  has_many :public_services
  has_many :company_shares
  has_many :jobs
  has_many :activities
  has_many :benefits
  has_many :sponsorships
  has_many :events
  has_many :incomes
  has_many :properties
  has_many :money_properties
  has_many :vehicle_properties
  has_many :other_properties
  has_many :movable_properties
  has_many :duties
  has_many :offices
  has_many :meetings
  
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
  
  
  def should_require_offices
    !offices_has_no_offices && !offices_nie_je_poslanec
  end
  def should_show_meetings
    !!meetings_has_no_meetings == false && !!meetings_not_presented == false
  end
end
