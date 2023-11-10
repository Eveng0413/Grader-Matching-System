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

ActiveRecord::Schema[7.0].define(version: 2023_10_27_024020) do
  create_table "admins", primary_key: "admin_email", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "available_times", primary_key: "time_id", force: :cascade do |t|
    t.string "weekday"
    t.string "student_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "start_time"
    t.time "end_time"
  end

  create_table "courses", primary_key: "c_id", force: :cascade do |t|
    t.integer "course_id"
    t.string "course_name"
    t.integer "credit_hour"
    t.string "academic_career"
    t.string "student_email"
    t.string "admin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "campus"
    t.string "term"
    t.string "course_discription"
    t.string "catalog_number"
  end

  create_table "instructors", primary_key: "faculty_email", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "persons", primary_key: "email", id: :string, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_persons_on_user_id"
  end

  create_table "recommends", id: false, force: :cascade do |t|
    t.string "student_email"
    t.string "faculty_email"
    t.string "admin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_requests", force: :cascade do |t|
    t.string "email", null: false
    t.string "role_requested", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_role_requests_on_email", unique: true
  end

  create_table "sections", primary_key: "s_id", force: :cascade do |t|
    t.integer "section_id"
    t.string "start_time"
    t.string "end_time"
    t.string "weekday"
    t.boolean "has_grader"
    t.date "start_date"
    t.date "end_date"
    t.string "semester_code"
    t.string "campus"
    t.string "faculty_email"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_grade_sections", id: false, force: :cascade do |t|
    t.string "student_email"
    t.string "faculty_email"
    t.string "admin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", primary_key: "student_email", id: :string, force: :cascade do |t|
    t.boolean "is_grader"
    t.string "evaluate"
    t.float "gpa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admins", "persons", column: "admin_email", primary_key: "email"
  add_foreign_key "available_times", "students", column: "student_email", primary_key: "student_email"
  add_foreign_key "courses", "admins", column: "admin_email", primary_key: "admin_email"
  add_foreign_key "courses", "students", column: "student_email", primary_key: "student_email"
  add_foreign_key "instructors", "persons", column: "faculty_email", primary_key: "email"
  add_foreign_key "persons", "users"
  add_foreign_key "recommends", "admins", column: "admin_email", primary_key: "admin_email"
  add_foreign_key "recommends", "instructors", column: "faculty_email", primary_key: "faculty_email"
  add_foreign_key "recommends", "students", column: "student_email", primary_key: "student_email"
  add_foreign_key "sections", "instructors", column: "faculty_email", primary_key: "faculty_email"
  add_foreign_key "student_grade_sections", "admins", column: "admin_email", primary_key: "admin_email"
  add_foreign_key "student_grade_sections", "instructors", column: "faculty_email", primary_key: "faculty_email"
  add_foreign_key "student_grade_sections", "students", column: "student_email", primary_key: "student_email"
  add_foreign_key "students", "persons", column: "student_email", primary_key: "email"
end
