class UpdatePatientsWithTreatmentStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :treatment_status,:boolean, default: false
  end
end
