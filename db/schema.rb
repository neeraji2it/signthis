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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140331214112) do

  create_table "documents", force: true do |t|
    t.integer  "architect_id"
    t.string   "first_spouse_first_name"
    t.string   "first_spouse_last_name"
    t.string   "second_spouse_first_name"
    t.string   "second_spouse_last_name"
    t.boolean  "foundation_building",                      default: true,     null: false
    t.boolean  "parenting_planning_i",                     default: true,     null: false
    t.boolean  "fiscal_mapping",                           default: true,     null: false
    t.boolean  "document_prepping",                        default: true,     null: false
    t.boolean  "final_review",                             default: true,     null: false
    t.boolean  "parenting_planning_ii",                    default: true,     null: false
    t.boolean  "fiscal_mapping_ii",                        default: true,     null: false
    t.boolean  "parenting_planning_iii",                   default: false,    null: false
    t.boolean  "fiscal_mapping_iii",                       default: false,    null: false
    t.boolean  "first_spouse_detour_meeting",              default: false,    null: false
    t.text     "first_spouse_detour_meeting_description"
    t.boolean  "second_spouse_detour_meeting",             default: false,    null: false
    t.text     "second_spouse_detour_meeting_description"
    t.string   "price"
    t.text     "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "first_spouse_signature_id"
    t.integer  "second_spouse_signature_id"
    t.string   "first_spouse_email"
    t.string   "second_spouse_email"
    t.string   "billable_hour",                            default: "600.00"
    t.boolean  "third_detour_meeting",                     default: false
    t.boolean  "fourth_detour_meeting",                    default: false
    t.text     "third_detour_meeting_description"
    t.text     "fourth_detour_meeting_description"
    t.string   "additional_sessions"
    t.string   "stripe_payment_id"
  end

  create_table "links", force: true do |t|
    t.integer  "document_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signatures", force: true do |t|
    t.string   "data",       default: ""
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
