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

ActiveRecord::Schema[7.0].define(version: 2024_05_19_174208) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", primary_key: "admin_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", primary_key: "appointment_id", id: :string, force: :cascade do |t|
    t.date "appointment_date"
    t.string "appointment_status", default: "pending"
    t.date "bmt_date"
    t.boolean "fbc_status", default: false
    t.boolean "bp_status", default: false
    t.string "bmt_report"
    t.string "fbc_report"
    t.string "bp_report"
    t.string "patient_id", null: false
    t.string "nurse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", primary_key: "doctor_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nurses", primary_key: "nurse_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "ward_num", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", primary_key: "patient_id", id: :string, force: :cascade do |t|
    t.date "dob"
    t.string "nic"
    t.text "address"
    t.string "gender"
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telephone"
    t.boolean "permanent_status", default: false
    t.boolean "diagnose_status", default: false
    t.boolean "appointment_status", default: false
    t.string "blood_type"
    t.string "admission_status", default: "appointment"
    t.string "bht_number"
    t.string "current_diagnose", default: "not_diagnosed"
    t.string "stage_of_treatment", default: "not_started"
    t.string "accommodation_type", default: "not_selected"
  end

  create_table "wards", primary_key: "ward_num", id: :string, force: :cascade do |t|
    t.string "patient_gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "nurses", primary_key: "nurse_id"
  add_foreign_key "appointments", "patients", primary_key: "patient_id"
  add_foreign_key "nurses", "wards", column: "ward_num", primary_key: "ward_num"
end
