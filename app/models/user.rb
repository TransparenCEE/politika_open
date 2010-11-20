require 'digest/sha1'

class User
  
  include Mongoid::Document
  include Forms::MongoidDocument
  
  # ETL
  field :etl_sid, :type => Integer
  field :etl_verejny_cinnitel_sid, :type => Integer
  
  # Basic fields
  field :email
  field :password
  field :telephone_number
  
  # Booleans
  field :is_active, :type => Boolean, :default => false
  field :is_politician, :type => Boolean
  field :is_candidate, :type => Boolean
  
  # Cached fields
  field :cached_candidature_party
  field :cached_candidature_election
  field :cached_candidature_function
  field :cached_current_party
  field :cached_candidature_town
  before_save :save_cached_fields
  
  field :is_super_admin, :type => Boolean
  
  attr_accessor :password_confirmation, :password_changed, :is_accepting_rules
  
  validates_acceptance_of :is_accepting_rules
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, :if => :validate_password?
  validates_presence_of :password_confirmation, :if => :validate_password?
  validates_confirmation_of :password, :if => :validate_password?
  
  validates_presence_of :basic_information_first_name
  validates_presence_of :basic_information_last_name
  validates_presence_of :basic_information_date_of_birth
  
  validates_format_of :email, :with => /^(.+)@(.+)\.(.+)$/
  
  validates_presence_of :telephone_number
  validates_length_of :telephone_number, :minimum => 5
  
  validate :type_picked
  
  before_save :encode_password, :if => :password_changed
  
  index_field :basic_information_first_name
  index_field :basic_information_last_name
  index_field :_id
  index_field :email
  index_field :telephone_number
  index_field :cached_candidature_town
  
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
  
  def encode_password
    write_attribute(:password, Digest::SHA1.hexdigest(self.password.to_s))
  end
  
  def self.authenticate(email, password)
    password = Digest::SHA1.hexdigest(password.to_s)
    user = self.first(:conditions => {:email => email, :password => password})
    user ? user : false
  end
  
  def name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end
  
  def full_name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end
  
  def should_show_meetings
    !!meetings_has_no_meetings == false && !!meetings_not_presented == false
  end
  
  def should_show_persons
    !!persons_has_none == false && !!persons_not_presented == false
  end
  
  def should_show_colleagues
    !!colleagues_has_none == false && !!colleagues_not_presented == false
  end
  
  def should_show_campaigns
    !!campaigns_has_none == false && !!campaigns_not_presented == false
  end
  
  def should_require_offices
    !offices_has_no_offices && !offices_nie_je_poslanec
  end
  
  def type_picked
    unless is_politician || is_candidate
      errors.add_to_base "Vyberte si či ste politik, kandidát, alebo oboje."
    end
  end
  
  def is_published
    count_of_invalid_fields == 0
  end
  
  def self.count_published
    self.count_valid
  end
  
  def self.count_valid
    self.where({:count_of_invalid_fields => 0}).count
  end
  
  def self.count_active
    self.where({:is_active => true}).count
  end
  
  def self.count_live
    self.where({:count_of_invalid_fields => 0, :is_active => true}).count
  end
  
  def count_of_invalid_forms
    forms.select { |f| f.has_invalid_fields? }.count
  end
  
  def current_item_for(form_name, sort_method)
    method_name = form_name.to_s.pluralize
    items_for_form = self.send(method_name)
    last_by_date = items_for_form.sort_by do |item|
      item.send(sort_method) || Date.today
    end.last
    
    last_by_date
  end
  
  def current_candidature
    current_item_for(:candidature, :basic_date)
  end
  
  def current_party
    current_item_for(:party, :basic_information_from)
  end
  
  # Deprecated
  def party
    cached_candidature_party
  end
  
  protected
  
  def save_cached_fields
    candidature = current_candidature
    if candidature
      self.cached_candidature_election = candidature.basic_election
      self.cached_candidature_party = candidature.basic_candidated_for
      self.cached_candidature_function = candidature.basic_function
      self.cached_candidature_town = candidature.basic_candidated_for_town
    else
      self.cached_candidature_election = nil
      self.cached_candidature_party = nil
      self.cached_candidature_function = nil
      self.cached_candidature_town = nil
    end
    
    party = current_party
    if party
      self.cached_current_party = party.basic_information_party
    else
      self.cached_current_party = nil
    end
  end
  
end