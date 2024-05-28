class CreateTreatmentRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :treatment_records, id: false do |t|
      t.string :treatment_record_id, primary_key: true, unique: true
      t.boolean :treatment_status, default: false
      t.date :treatment_date
      t.date :last_treatment_date
      t.string :treatment_notes
      t.string :nurse_id, null: false
      t.string :patient_id, null: false
      t.string :treatment_id, null: false

      t.timestamps
    end

    add_foreign_key :treatment_records, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :treatment_records, :nurses, column: :nurse_id, primary_key: :nurse_id
    add_foreign_key :treatment_records, :treatment_plans, column: :treatment_id, primary_key: :treatment_id
  end
end
