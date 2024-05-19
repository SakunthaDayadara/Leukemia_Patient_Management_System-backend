class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments, id: false do |t|
      t.string :appointment_id, primary_key: true, unique: true
      t.date :appointment_date
      t.string :appointment_status, default: 'pending'
      t.date :bmt_date
      t.boolean :fbc_status, default: false
      t.boolean :bp_status, default: false
      t.string :bmt_report
      t.string :fbc_report
      t.string :bp_report
      t.string :patient_id, null: false
      t.string :nurse_id, null: false

      t.timestamps
    end

    add_foreign_key :appointments, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :appointments, :nurses, column: :nurse_id, primary_key: :nurse_id

  end
end
