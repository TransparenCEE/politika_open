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

ActiveRecord::Schema.define(:version => 20120130000947) do

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
  end

end
