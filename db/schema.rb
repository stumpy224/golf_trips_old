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

ActiveRecord::Schema.define(version: 2018_12_11_144723) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "golfers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "email"
    t.string "phone"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_registered"
    t.index ["email"], name: "index_golfers_on_email", unique: true
  end

  create_table "holes", force: :cascade do |t|
    t.integer "course_id"
    t.integer "number"
    t.integer "par"
    t.integer "handicap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_holes_on_course_id"
  end

  create_table "tees", force: :cascade do |t|
    t.integer "course_id"
    t.string "name"
    t.integer "rating"
    t.integer "slope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_tees_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "email"
    t.integer "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "is_admin"
    t.string "activation_digest"
    t.boolean "is_activated"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "yardages", force: :cascade do |t|
    t.integer "tee_id"
    t.integer "hole_id"
    t.integer "yards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hole_id"], name: "index_yardages_on_hole_id"
    t.index ["tee_id"], name: "index_yardages_on_tee_id"
  end

end
