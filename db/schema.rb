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

ActiveRecord::Schema[7.0].define(version: 2024_05_28_213211) do
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

  create_table "beds", primary_key: "bed_id", id: :string, force: :cascade do |t|
    t.string "ward_num", null: false
    t.boolean "is_occupied", default: false
    t.string "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnoses", primary_key: "diagnose_id", id: :string, force: :cascade do |t|
    t.string "category", default: "not_diagnosed"
    t.string "doctor_notes", default: "no_notes"
    t.string "doctor_id", null: false
    t.string "patient_id", null: false
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
    t.boolean "advance_diagnose_status", default: false
    t.boolean "treatment_status", default: false
  end

  create_table "references", primary_key: "reference_id", id: :string, force: :cascade do |t|
    t.string "reference_note"
    t.string "referred_doctor_id"
    t.string "referred_doctor_notes"
    t.string "reference_status", default: "pending"
    t.string "doctor_id", null: false
    t.string "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_plans", primary_key: "treatment_id", id: :string, force: :cascade do |t|
    t.string "treatment_type", default: "not_selected"
    t.string "treatment_status", default: "not_started"
    t.string "doctor_id", null: false
    t.string "patient_id", null: false
    t.string "diagnose_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_records", primary_key: "treatment_record_id", id: :string, force: :cascade do |t|
    t.boolean "treatment_status", default: false
    t.date "treatment_date"
    t.date "last_treatment_date"
    t.string "treatment_notes"
    t.string "nurse_id", null: false
    t.string "patient_id", null: false
    t.string "treatment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wards", primary_key: "ward_num", id: :string, force: :cascade do |t|
    t.string "patient_gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "nurses", primary_key: "nurse_id"
  add_foreign_key "appointments", "patients", primary_key: "patient_id"
  add_foreign_key "beds", "patients", primary_key: "patient_id"
  add_foreign_key "beds", "wards", column: "ward_num", primary_key: "ward_num"
  add_foreign_key "diagnoses", "doctors", primary_key: "doctor_id"
  add_foreign_key "diagnoses", "patients", primary_key: "patient_id"
  add_foreign_key "nurses", "wards", column: "ward_num", primary_key: "ward_num"
  add_foreign_key "references", "doctors", primary_key: "doctor_id"
  add_foreign_key "references", "patients", primary_key: "patient_id"
  add_foreign_key "treatment_plans", "diagnoses", column: "diagnose_id", primary_key: "diagnose_id"
  add_foreign_key "treatment_plans", "doctors", primary_key: "doctor_id"
  add_foreign_key "treatment_plans", "patients", primary_key: "patient_id"
  add_foreign_key "treatment_records", "nurses", primary_key: "nurse_id"
  add_foreign_key "treatment_records", "patients", primary_key: "patient_id"
  add_foreign_key "treatment_records", "treatment_plans", column: "treatment_id", primary_key: "treatment_id"
end
