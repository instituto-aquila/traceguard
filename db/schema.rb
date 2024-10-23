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

ActiveRecord::Schema[7.2].define(version: 2024_10_23_180536) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "error_logs", force: :cascade do |t|
    t.integer "code"
    t.string "erro"
    t.text "backtrace"
    t.bigint "application_id", null: false
    t.string "url"
    t.string "http_method"
    t.datetime "date"
    t.bigint "status_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_error_logs_on_application_id"
    t.index ["status_id"], name: "index_error_logs_on_status_id"
    t.index ["user_id"], name: "index_error_logs_on_user_id"
  end

  create_table "pages_visiteds", force: :cascade do |t|
    t.bigint "user_monitoring_id", null: false
    t.string "page_url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "duration_seconds"
    t.integer "publication_id"
    t.string "publication_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_monitoring_id"], name: "index_pages_visiteds_on_user_monitoring_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_monitorings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "application_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_user_monitorings_on_application_id"
    t.index ["user_id"], name: "index_user_monitorings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "error_logs", "applications"
  add_foreign_key "error_logs", "statuses"
  add_foreign_key "error_logs", "users"
  add_foreign_key "pages_visiteds", "user_monitorings"
  add_foreign_key "user_monitorings", "applications"
  add_foreign_key "user_monitorings", "users"
end
