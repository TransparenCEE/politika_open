# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120130144308) do

  create_table "activities", :force => true do |t|
    t.string   "institution_name"
    t.string   "institution_sector"
    t.string   "institution_form"
    t.string   "institution_nubmer"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.boolean  "activity_information_is_honored"
    t.string   "activity_information_activity"
    t.string   "activity_information_reward_currency"
    t.string   "activity_information_reward"
    t.date     "activity_information_date_from"
    t.date     "activity_information_date_to"
    t.text     "activity_information_notes"
    t.integer  "user_id",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "benefits", :force => true do |t|
    t.string   "provider_name"
    t.string   "provider_sector"
    t.string   "provider_form"
    t.string   "provider_number"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "benefit_description"
    t.string   "benefit_value"
    t.string   "benefit_value_currency"
    t.date     "benefit_date_from"
    t.date     "benefit_date_to"
    t.text     "benefit_notes"
    t.integer  "user_id",                :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "benefits", ["user_id"], :name => "index_benefits_on_user_id"

  create_table "company_shares", :force => true do |t|
    t.string   "basic_information_name"
    t.string   "basic_information_form"
    t.string   "basic_information_number"
    t.boolean  "basic_information_connected_to_public_sector"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "participation_position"
    t.string   "participation_share"
    t.string   "participation_currency"
    t.string   "participation_percent"
    t.date     "participation_date_from"
    t.date     "participation_date_to"
    t.text     "participation_notes"
    t.integer  "user_id",                                      :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "company_shares", ["user_id"], :name => "index_company_shares_on_user_id"

  create_table "duties", :force => true do |t|
    t.string   "basic_description"
    t.string   "basic_acquirement_type"
    t.string   "basic_provider"
    t.string   "basic_possesion_type"
    t.string   "basic_share"
    t.date     "basic_acquirement_date"
    t.date     "basic_expiration_date"
    t.string   "value_total"
    t.string   "value_total_currency"
    t.string   "value_amount"
    t.string   "value_currency"
    t.string   "value_timeframe"
    t.text     "value_notes"
    t.string   "institution_title_or_name"
    t.string   "institution_sector"
    t.string   "institution_form"
    t.string   "institution_number"
    t.boolean  "institution_no_approvement"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.integer  "user_id",                    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "duties", ["user_id"], :name => "index_duties_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "organisator_name"
    t.string   "organisator_sector"
    t.string   "organisator_form"
    t.string   "organisator_number"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "event_type"
    t.string   "event_purpose"
    t.string   "event_state"
    t.string   "event_town"
    t.date     "event_date_from"
    t.date     "event_date_to"
    t.string   "event_payed"
    t.string   "event_amount_currency"
    t.string   "event_amount"
    t.text     "event_notes"
    t.integer  "user_id",               :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "incomes", :force => true do |t|
    t.string   "basic_year"
    t.string   "basic_amount_main"
    t.string   "basic_currency_main"
    t.string   "basic_amount_other"
    t.string   "basic_currency_other"
    t.integer  "user_id",              :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "incomes", ["user_id"], :name => "index_incomes_on_user_id"

  create_table "jobs", :force => true do |t|
    t.string   "employer_name"
    t.string   "employer_sector"
    t.string   "employer_form"
    t.string   "employer_number"
    t.string   "employer_position"
    t.date     "employer_date_from"
    t.date     "employer_date_to"
    t.string   "employer_address_state"
    t.string   "employer_address_county"
    t.string   "employer_address_district"
    t.string   "employer_address_town"
    t.string   "employer_address_street"
    t.string   "employer_address_zip"
    t.text     "employer_address_notes"
    t.integer  "user_id",                   :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id"

  create_table "meetings", :force => true do |t|
    t.string   "basic_information_type"
    t.string   "basic_information_purpose"
    t.string   "basic_information_state"
    t.string   "basic_information_town"
    t.date     "basic_information_date_from"
    t.date     "basic_information_date_to"
    t.string   "basic_information_payed"
    t.string   "basic_information_amount"
    t.string   "basic_information_currency"
    t.text     "basic_information_notes"
    t.string   "institution_title_or_name"
    t.string   "institution_sector"
    t.string   "institution_form"
    t.string   "institution_number"
    t.boolean  "institution_no_approvement"
    t.string   "institution_title"
    t.string   "institution_name"
    t.string   "institution_surname"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.integer  "user_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "meetings", ["user_id"], :name => "index_meetings_on_user_id"

  create_table "money_properties", :force => true do |t|
    t.string   "basic_year"
    t.string   "basic_value"
    t.string   "basic_currency"
    t.text     "basic_notes"
    t.integer  "user_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "money_properties", ["user_id"], :name => "index_money_properties_on_user_id"

  create_table "movable_properties", :force => true do |t|
    t.string   "basic_year"
    t.string   "basic_movable_property"
    t.string   "basic_currency"
    t.text     "basic_notes"
    t.integer  "user_id",                :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "movable_properties", ["user_id"], :name => "index_movable_properties_on_user_id"

  create_table "offices", :force => true do |t|
    t.string   "basic_type"
    t.string   "basic_name"
    t.string   "basic_sector"
    t.string   "basic_form"
    t.string   "basic_number"
    t.date     "basic_date_from"
    t.date     "basic_date_to"
    t.string   "basic_amount"
    t.string   "basic_currency"
    t.string   "basic_timeframe"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "address_contact"
    t.text     "other_note"
    t.integer  "user_id",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "offices", ["user_id"], :name => "index_offices_on_user_id"

  create_table "other_properties", :force => true do |t|
    t.string   "basic_description"
    t.string   "basic_acquirement"
    t.date     "basic_acquirement_date"
    t.date     "basic_sale_date"
    t.string   "basic_acquirement_value"
    t.string   "basic_currency"
    t.string   "basic_possesion_type"
    t.string   "basic_share"
    t.text     "basic_notes"
    t.integer  "user_id",                 :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "other_properties", ["user_id"], :name => "index_other_properties_on_user_id"

  create_table "parties", :force => true do |t|
    t.string   "basic_information_party"
    t.text     "basic_information_position"
    t.date     "basic_information_from"
    t.date     "basic_information_to"
    t.text     "basic_information_notes"
    t.integer  "user_id",                    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "parties", ["user_id"], :name => "index_parties_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "basic_relation"
    t.boolean  "basic_no_approvement"
    t.string   "information_title"
    t.string   "information_name"
    t.string   "information_surname"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.boolean  "ownership_not_presented"
    t.boolean  "ownership_none"
    t.boolean  "ownership_not_known"
    t.string   "ownership_name"
    t.string   "ownership_sector"
    t.string   "ownership_form"
    t.string   "ownership_number"
    t.string   "institution_address_state"
    t.string   "institution_address_county"
    t.string   "institution_address_district"
    t.string   "institution_address_town"
    t.string   "institution_address_street"
    t.string   "institution_address_zip"
    t.string   "function_function"
    t.string   "function_share"
    t.string   "function_currency"
    t.string   "function_percent_share"
    t.date     "function_date_from"
    t.date     "function_date_to"
    t.text     "function_notes"
    t.integer  "user_id",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "people", ["user_id"], :name => "index_people_on_user_id"

  create_table "properties", :force => true do |t|
    t.string   "basic_description"
    t.string   "basic_acquirement"
    t.boolean  "basic_has_income"
    t.string   "basic_acreage"
    t.string   "basic_parcel_number"
    t.string   "basic_lv_number"
    t.string   "basic_acquirement_year"
    t.string   "basic_acquirement_value"
    t.string   "basic_acquirement_currency"
    t.string   "basic_year"
    t.string   "basic_market_value_estimate"
    t.string   "basic_market_value_estimate_currency"
    t.string   "basic_possesion_type"
    t.string   "basic_share"
    t.date     "basic_sale_date"
    t.string   "location_state"
    t.string   "location_county"
    t.string   "location_district"
    t.string   "location_town"
    t.text     "location_notes"
    t.integer  "user_id",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "public_services", :force => true do |t|
    t.string   "basic_information_service"
    t.date     "basic_information_from"
    t.date     "basic_information_to"
    t.string   "basic_information_candidate_for_party"
    t.string   "basic_information_member_of"
    t.text     "basic_information_notes"
    t.integer  "user_id",                               :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "public_services", ["user_id"], :name => "index_public_services_on_user_id"

  create_table "sponsorships", :force => true do |t|
    t.string   "provider_name"
    t.string   "provider_sector"
    t.string   "provider_form"
    t.string   "provider_number"
    t.boolean  "address_not_allowed_to_publish_information"
    t.string   "address_state"
    t.string   "address_county"
    t.string   "address_district"
    t.string   "address_town"
    t.string   "address_street"
    t.string   "address_zip"
    t.text     "address_notes"
    t.string   "sponsorship_sponsorship"
    t.string   "sponsorship_purpose"
    t.date     "sponsorship_date"
    t.string   "sponsorship_value_currency"
    t.string   "sponsorship_value"
    t.integer  "user_id",                                    :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "sponsorships", ["user_id"], :name => "index_sponsorships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "telephone_number"
    t.boolean  "is_active"
    t.boolean  "is_politician"
    t.boolean  "is_candidate"
    t.integer  "etl_sid"
    t.integer  "etl_verejny_cinnitel_sid"
    t.boolean  "is_super_admin"
    t.string   "basic_information_first_name"
    t.string   "basic_information_last_name"
    t.date     "basic_information_date_of_birth"
    t.boolean  "is_accepting_rules"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "basic_information_title"
    t.string   "basic_information_second_title"
    t.string   "basic_information_birth_last_name"
    t.string   "basic_information_photo"
    t.string   "basic_information_telephone_number"
    t.string   "basic_information_email"
    t.string   "basic_information_web"
    t.string   "basic_information_blog"
    t.string   "basic_information_im"
    t.text     "basic_information_social_network"
    t.text     "basic_information_about_me"
    t.string   "basic_information_county"
    t.string   "basic_information_district"
    t.string   "basic_information_address_city"
    t.string   "basic_information_address_address"
    t.string   "basic_information_address_zipcode"
    t.string   "basic_information_note"
    t.boolean  "political_party_is_not_in_political_party"
    t.boolean  "public_service_is_not_in_public_service"
    t.boolean  "company_shares_not_owns_shares"
    t.boolean  "jobs_has_no_job"
    t.boolean  "activities_has_no_activities"
    t.boolean  "benefits_has_no_benefits"
    t.boolean  "sponsorships_has_no_sponsorships"
    t.boolean  "events_has_no_events"
    t.boolean  "events_events_not_expensive"
    t.boolean  "events_events_expensive"
    t.boolean  "unmovable_property_no_properties"
    t.boolean  "movable_property_has_no_vehicle_property"
    t.boolean  "movable_property_has_no_other_property"
    t.boolean  "duties_has_no_duties"
    t.boolean  "offices_has_no_offices"
    t.boolean  "offices_nie_je_poslanec"
    t.boolean  "meetings_has_no_meetings"
    t.boolean  "meetings_not_presented"
    t.boolean  "persons_has_none"
    t.boolean  "persons_not_presented"
  end

  create_table "vehicle_properties", :force => true do |t|
    t.string   "basic_brand"
    t.string   "basic_model"
    t.string   "basic_year"
    t.string   "basic_acquirement"
    t.date     "basic_acquirement_date"
    t.date     "basic_sale_date"
    t.string   "basic_acquirement_value"
    t.string   "basic_currency"
    t.string   "basic_possesion_type"
    t.string   "basic_share"
    t.string   "basic_mileage"
    t.text     "basic_notes"
    t.integer  "user_id",                 :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "vehicle_properties", ["user_id"], :name => "index_vehicle_properties_on_user_id"

end
