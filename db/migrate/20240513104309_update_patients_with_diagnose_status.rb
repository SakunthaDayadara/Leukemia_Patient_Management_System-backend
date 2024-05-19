class UpdatePatientsWithDiagnoseStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :diagnose_status,:boolean, default: false
  end
end
