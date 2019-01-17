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

ActiveRecord::Schema.define(version: 2019_01_16_233346) do

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

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
    t.boolean "is_board_member"
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

  create_table "lodging_types", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lodgings", force: :cascade do |t|
    t.integer "lodging_type_id"
    t.string "room"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lodging_type_id"], name: "index_lodgings_on_lodging_type_id"
  end

  create_table "outing_golfers", force: :cascade do |t|
    t.integer "outing_id"
    t.integer "golfer_id"
    t.integer "lodging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golfer_id"], name: "index_outing_golfers_on_golfer_id"
    t.index ["lodging_id"], name: "index_outing_golfers_on_lodging_id"
    t.index ["outing_id"], name: "index_outing_golfers_on_outing_id"
  end

  create_table "outings", force: :cascade do |t|
    t.integer "course_id"
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_outings_on_course_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "team_id"
    t.integer "hole_id"
    t.integer "strokes"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hole_id"], name: "index_scores_on_hole_id"
    t.index ["team_id"], name: "index_scores_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "outing_golfer_id"
    t.integer "team_number"
    t.integer "rank_number"
    t.string "rank_letter"
    t.integer "points_expected"
    t.integer "points_actual"
    t.date "team_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points_plus_minus"
    t.index ["outing_golfer_id"], name: "index_teams_on_outing_golfer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "is_activated"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "is_admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
