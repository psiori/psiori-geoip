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

ActiveRecord::Schema.define(version: 20141110185613) do

  create_table "city_blocks", force: true do |t|
    t.integer  "ip_start",   limit: 8, null: false
    t.integer  "ip_end",     limit: 8, null: false
    t.integer  "loc_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_blocks", ["ip_start"], name: "index_city_blocks_on_ip_start", unique: true

  create_table "city_locations", force: true do |t|
    t.string   "country_code"
    t.string   "region_code"
    t.string   "city_name"
    t.string   "postal_code"
    t.decimal  "latitude",     default: 0.0, null: false
    t.decimal  "longitude",    default: 0.0, null: false
    t.string   "metro_code"
    t.string   "area_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
