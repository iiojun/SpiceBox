# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_30_055354) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days", force: :cascade do |t|
    t.bigint "conference_id", null: false
    t.string "title"
    t.text "description"
    t.integer "seq_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_days_on_conference_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "presentation_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_id"], name: "index_evaluations_on_presentation_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "judges", force: :cascade do |t|
    t.bigint "evaluation_id", null: false
    t.string "question"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_judges_on_evaluation_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.bigint "slot_id", null: false
    t.string "title"
    t.string "authors"
    t.string "presenter"
    t.text "description"
    t.string "contact_email"
    t.string "url"
    t.string "misc"
    t.boolean "evaluated"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disclose", default: false
    t.index ["slot_id"], name: "index_presentations_on_slot_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.string "title"
    t.text "description"
    t.string "chair"
    t.string "room"
    t.string "s_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_slots_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "day_id", null: false
    t.string "title"
    t.text "description"
    t.integer "seq_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_tracks_on_day_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "fullname"
    t.string "role", default: "member"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "days", "conferences"
  add_foreign_key "evaluations", "presentations"
  add_foreign_key "evaluations", "users"
  add_foreign_key "judges", "evaluations"
  add_foreign_key "presentations", "slots"
  add_foreign_key "slots", "tracks"
  add_foreign_key "tracks", "days"
end
