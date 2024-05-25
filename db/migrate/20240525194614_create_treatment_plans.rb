class CreateTreatmentPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :treatment_plans, id: false do |t|
      t.string :treatment_id, primary_key: true, unique: true
      t.string :treatment_type, default: 'not_selected'
      t.string :treatment_status, default: 'not_started'
      t.string :doctor_id, null: false
      t.string :patient_id, null: false
      t.string :diagnose_id, null: false

      t.timestamps
    end

    add_foreign_key :treatment_plans, :doctors, column: :doctor_id, primary_key: :doctor_id
    add_foreign_key :treatment_plans, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :treatment_plans, :diagnoses, column: :diagnose_id, primary_key: :diagnose_id

  end
end
