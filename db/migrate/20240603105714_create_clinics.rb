class CreateClinics < ActiveRecord::Migration[7.0]
  def change
    create_table :clinics, id: false do |t|
      t.string :clinic_id, primary_key: true, unique: true
      t.date :clinic_date
      t.date :last_clinic_date
      t.string :clinic_type
      t.string :clinic_status, default: "scheduled"
      t.string :doctor_id
      t.string :patient_id, null: false
      t.string :nurse_id

      t.timestamps
    end

    add_foreign_key :clinics, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :clinics, :doctors, column: :doctor_id, primary_key: :doctor_id
    add_foreign_key :clinics, :nurses, column: :nurse_id, primary_key: :nurse_id
  end
end
