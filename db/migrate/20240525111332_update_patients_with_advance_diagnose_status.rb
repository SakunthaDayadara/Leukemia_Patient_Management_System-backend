class UpdatePatientsWithAdvanceDiagnoseStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :advance_diagnose_status,:boolean, default: false
  end
end
