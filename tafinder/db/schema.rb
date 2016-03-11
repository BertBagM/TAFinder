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

ActiveRecord::Schema.define(version: 20160311011821) do

  create_table "applications", force: :cascade do |t|
    t.integer  "studentNum"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.decimal  "GPA"
    t.string   "faculty"
    t.integer  "yearOfStudy"
    t.boolean  "graduateStudent"
    t.integer  "ubcEmployeeId"
    t.string   "program"
    t.string   "gender"
    t.string   "streetAddress"
    t.string   "city"
    t.string   "postalCode"
    t.string   "homePhone"
    t.string   "cellPhone"
    t.boolean  "graduateFTStatus"
    t.boolean  "previousUTAPosition"
    t.integer  "preferredHours"
    t.integer  "maximumHours"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

  create_table "rankings", force: :cascade do |t|
    t.integer  "application_id",                 null: false
    t.integer  "term_id",                        null: false
    t.integer  "position"
    t.boolean  "locked",         default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string   "year",       limit: 4,                 null: false
    t.string   "semester",   limit: 1, default: "F",   null: false
    t.boolean  "open",                 default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
