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

ActiveRecord::Schema.define(version: 20151009222916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 500,  null: false
    t.string   "category",   limit: 300,  null: false
    t.string   "author",     limit: 300,  null: false
    t.text     "body",                    null: false
    t.string   "image_url",  limit: 1000, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name",  limit: 200
    t.string   "last_name",   limit: 200
    t.string   "address",     limit: 200
    t.string   "city",        limit: 100
    t.string   "state",       limit: 2
    t.string   "zip",         limit: 16
    t.string   "phone",       limit: 16
    t.string   "email",       limit: 100
    t.boolean  "is_business"
    t.boolean  "is_family"
    t.boolean  "is_resident"
    t.decimal  "longitude",               precision: 10, scale: 6
    t.decimal  "latitude",                precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "correspondences", force: :cascade do |t|
    t.string  "note",       limit: 1000, null: false
    t.integer "contact_id"
  end

  create_table "donations", force: :cascade do |t|
    t.float    "amount",       null: false
    t.datetime "created_at",   null: false
    t.integer  "contact_id",   null: false
    t.string   "stripe_token"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",        limit: 300,  null: false
    t.string   "location",    limit: 200,  null: false
    t.string   "description", limit: 1000, null: false
    t.string   "image_url",   limit: 1000, null: false
    t.date     "event_date",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", force: :cascade do |t|
    t.string  "interest",   limit: 200, null: false
    t.integer "contact_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.boolean  "status"
    t.boolean  "lifetime"
    t.date     "expiration_date"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.string  "token",       null: false
    t.boolean "schedule",    null: false
    t.integer "donation_id", null: false
    t.string  "customer_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "correspondences", "contacts", name: "correspondences_contact_id_fkey"
  add_foreign_key "donations", "contacts", name: "donations_contact_id_fkey"
  add_foreign_key "interests", "contacts", name: "interests_contact_id_fkey"
  add_foreign_key "memberships", "contacts", name: "memberships_contact_id_fkey"
end
