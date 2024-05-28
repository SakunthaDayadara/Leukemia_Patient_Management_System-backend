class CreateReferences < ActiveRecord::Migration[7.0]
  def change
    create_table :references, id: false do |t|
      t.string :reference_id, primary_key: true, unique: true
      t.string :reference_note
      t.string :referred_doctor_id
      t.string :referred_doctor_notes
      t.string :reference_status, default: 'pending'
      t.string :doctor_id, null: false
      t.string :patient_id, null: false

      t.timestamps
    end

    add_foreign_key :references, :doctors, column: :doctor_id, primary_key: :doctor_id
    add_foreign_key :references, :patients, column: :patient_id, primary_key: :patient_id
  end
end
