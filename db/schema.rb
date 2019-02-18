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

ActiveRecord::Schema.define(version: 2019_02_05_040427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "meeting_id", null: false
    t.datetime "arrival_time"
    t.datetime "departure_time"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_attendances_on_meeting_id"
    t.index ["member_id"], name: "index_attendances_on_member_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_clubs_on_creator_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "title"
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_meetings_on_club_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_members_on_club_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.bigint "user_id", null: false
    t.integer "level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_roles_on_club_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super_admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "meetings"
  add_foreign_key "attendances", "members"
  add_foreign_key "clubs", "users", column: "creator_id"
  add_foreign_key "meetings", "clubs"
  add_foreign_key "members", "clubs"
  add_foreign_key "members", "users"
  add_foreign_key "roles", "clubs"
  add_foreign_key "roles", "users"
end
