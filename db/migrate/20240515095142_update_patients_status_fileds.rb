class UpdatePatientsStatusFileds < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :appointment_status,:boolean, default: false
    add_column :patients, :blood_type, :string
    add_column :patients, :admission_status, :string, default: 'appointment'
    add_column :patients, :bht_number, :string
    add_column :patients, :current_diagnose, :string, default: 'not_diagnosed'
    add_column :patients, :stage_of_treatment, :string, default: 'not_started'
    add_column :patients, :accommodation_type, :string, default: 'not_selected'
  end
end
