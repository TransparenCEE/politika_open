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

ActiveRecord::Schema.define(:version => 20120129161151) do

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
  end

end
