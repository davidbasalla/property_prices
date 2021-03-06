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

ActiveRecord::Schema.define(version: 20160227153634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sales", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "amount"
    t.date     "date"
    t.string   "postcode"
    t.string   "property_type"
    t.string   "old_new"
    t.string   "duration"
    t.string   "paon"
    t.string   "saon"
    t.string   "street"
    t.string   "locality"
    t.string   "town_city"
    t.string   "district"
    t.string   "county"
    t.string   "ppd_category_type"
    t.string   "record_status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "sales", ["date"], name: "date_ix", using: :btree
  add_index "sales", ["postcode"], name: "postcode_ix", using: :btree
  add_index "sales", ["property_type"], name: "prop_type_ix", using: :btree

end
