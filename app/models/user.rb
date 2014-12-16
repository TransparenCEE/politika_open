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
  has_many :persons
  has_many :colleagues
  has_many :candidatures
  has_many :campaign
  has_many :others

  has_many :visits

  accepts_nested_attributes_for :parties, :public_services, :company_shares, :jobs, :activities,
                                :benefits, :sponsorships, :events, :incomes, :properties, :money_properties,
                                :vehicle_properties, :other_properties, :money_properties, :duties,
                                :offices, :meetings, :persons, :colleagues, :candidatures, :campaign, :others

  attr_accessor :password_confirmation, :password_changed, :is_accepting_rules

  validates_presence_of :password, :if => :validate_password?
  validates_presence_of :password_confirmation, :if => :validate_password?
  validates_confirmation_of :password, :if => :validate_password?

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :basic_information_first_name
  validates_presence_of :basic_information_last_name
  validates_presence_of :basic_information_date_of_birth

  validates_format_of :email, :with => /^(.+)@(.+)\.(.+)$/

  validates_presence_of :telephone_number
  validates_length_of :telephone_number, minimum: 5, message: I18n.t('activerecord.errors.user.telephone_number_short')

  validates_acceptance_of :is_accepting_rules

  before_save :encode_password, :if => :password_changed
  def encode_password
    write_attribute(:password, Digest::SHA1.hexdigest(self.password.to_s))
  end

  before_save :save_cached_fields
  def save_cached_fields
    self.cached_current_party = current_party
    self.cached_candidature_party = candidature_party
    self.cached_candidature_election = candidature_election
    self.cached_candidature_function = candidature_function
    self.cached_candidature_town = candidature_town
    self.cached_candidature_date = candidature_date
  end

  before_save :count_invalid_fields
  def count_invalid_fields
    count = 0
    self.visible_forms.each do |form|
      count += form.count_of_invalid_fields
    end
    self.count_of_invalid_fields = count
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
    count_of_invalid_fields == 0
  end

  def name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end

  def full_name
    "%s %s" % [basic_information_first_name, basic_information_last_name]
  end

  def reset_password!
    new_password = SecureRandom.base64(6)
    self.password = new_password
    self.password_confirmation = password

    save(validate: false) ? new_password : nil
  end


  def should_require_offices
    !offices_has_no_offices && !offices_nie_je_poslanec
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

  def events_events_expensive_or_events_events_not_expensive
    events.present? || events_events_expensive? == true || events_events_not_expensive? == true
  end
  def events_events_expensive_or_events_has_no_events
    events.present? || events_events_expensive? == true || events_has_no_events? == true
  end
  def events_events_not_expensive_or_events_has_no_events
    events.present? || events_events_not_expensive? == true || events_has_no_events? == true
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
    visible_forms.select { |f| f.has_invalid_fields? }.count
  end

  def current_party
    parties.order("basic_information_from DESC").first.try(:basic_information_party)
  end
  def candidature_party
    candidatures.order("basic_date DESC").first.try(:basic_candidated_for)
  end
  def candidature_election
    candidatures.order("basic_date DESC").first.try(:basic_election)
  end
  def candidature_function
    candidatures.order("basic_date DESC").first.try(:basic_function)
  end
  def candidature_town
    candidatures.order("basic_date DESC").first.try(:basic_candidated_for_town)
  end
  def candidature_date
    candidatures.order("basic_date DESC").first.try(:basic_date)
  end

  define_index do
    indexes :basic_information_first_name, sortable: true
    indexes :basic_information_last_name, sortable: true
    indexes :basic_information_address_city
    indexes "replace(basic_information_address_zipcode, ' ', '')", as: :basic_information_address_zipcode

    indexes :email, sortable: true
    indexes :telephone_number, sortable: true

    indexes :cached_current_party, sortable: true
    indexes :cached_candidature_party, sortable: true
    indexes :cached_candidature_election, sortable: true
    indexes :cached_candidature_function, sortable: true
    indexes :cached_candidature_town, sortable: true

    indexes :updated_at, sortable: true
    indexes :count_of_invalid_fields
    indexes :is_active

    set_property delta: true
  end

  def log_visit(session_id)
    visit = Visit.find_or_initialize_by_session_id_and_user_id_and_access_date(session_id, self.id, Date.today)
    visit.save if visit.new_record?
  end

  def save_without_touch
    ActiveRecord::Base.record_timestamps = false
    result = save
    ActiveRecord::Base.record_timestamps = true
    result
  end

end
