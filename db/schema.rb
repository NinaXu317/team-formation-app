# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_09_014731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "group_id"
    t.string "type"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "content"
    t.index ["group_id"], name: "index_comments_on_group_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "pin"
    t.integer "professor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "voting", default: true
  end

  create_table "groups", force: :cascade do |t|
    t.integer "course_id"
    t.string "project_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.text "description"
    t.integer "vfirst", default: 0
    t.integer "vsecond", default: 0
    t.integer "vthird", default: 0
    t.boolean "active", default: true
  end

  create_table "holdprojects", force: :cascade do |t|
    t.string "project_name"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.text "description"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "first"
    t.integer "second"
    t.integer "third"
    t.integer "codingProficiency"
    t.integer "dreampartner"
    t.integer "course_id"
    t.string "schedule"
    t.index ["student_id"], name: "index_preferences_on_student_id"
  end

  create_table "professors", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated"
  end

  create_table "students", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated"
  end

  create_table "takings", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "votefirst", default: -1
    t.integer "votesecond", default: -1
    t.integer "votethird", default: -1
  end

  add_foreign_key "preferences", "students"
end
