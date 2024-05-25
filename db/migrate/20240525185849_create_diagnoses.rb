class CreateDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :diagnoses, id: false do |t|
      t.string :diagnose_id, primary_key: true, unique: true
      t.string :category, default: 'not_diagnosed'
      t.string :doctor_notes, default: 'no_notes'
      t.string :doctor_id, null: false
      t.string :patient_id, null: false

      t.timestamps
    end

    add_foreign_key :diagnoses, :doctors, column: :doctor_id, primary_key: :doctor_id
    add_foreign_key :diagnoses, :patients, column: :patient_id, primary_key: :patient_id
  end
end
