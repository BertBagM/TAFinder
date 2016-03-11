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
    t.integer  "student_id",                                                            null: false
    t.string   "first_name",                                                            null: false
    t.string   "last_name",                                                             null: false
    t.string   "email",                                                                 null: false
    t.decimal  "gpa",                           precision: 5, scale: 2
    t.string   "faculty",                                                               null: false
    t.integer  "study_year",                                            default: 1,     null: false
    t.boolean  "graduate",                                              default: false, null: false
    t.boolean  "graduate_full_time",                                    default: false, null: false
    t.integer  "ubc_employee_id"
    t.string   "program"
    t.string   "gender",                                                                null: false
    t.string   "street",                                                                null: false
    t.string   "city",                                                                  null: false
    t.string   "postal_code",                                                           null: false
    t.string   "home_phone",         limit: 14
    t.string   "cell_phone",         limit: 14
    t.boolean  "previous_ta",                                           default: false, null: false
    t.integer  "preferred_hours",                                       default: 12,    null: false
    t.integer  "maximum_hours",                                         default: 12,    null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "subject",      limit: 4,                 null: false
    t.string   "number",       limit: 3,                 null: false
    t.string   "section",      limit: 3
    t.string   "act_type",     limit: 3,                 null: false
    t.string   "days",         limit: 5, default: "",    null: false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "lab",                    default: false, null: false
    t.boolean  "mark",                   default: false, null: false
    t.boolean  "coord",                  default: false, null: false
    t.string   "graduate",     limit: 1, default: "U",   null: false
    t.integer  "enrolled_est",           default: 0,     null: false
    t.integer  "enrolled",               default: 0,     null: false
    t.integer  "released",               default: 0,     null: false
    t.integer  "capacity",               default: 0,     null: false
    t.string   "building",     limit: 3
    t.string   "room",         limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "preferred_courses", force: :cascade do |t|
    t.integer  "application_id", null: false
    t.integer  "course_id",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

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
    t.string   "email",         null: false
    t.string   "password",      null: false
    t.string   "password_salt", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
