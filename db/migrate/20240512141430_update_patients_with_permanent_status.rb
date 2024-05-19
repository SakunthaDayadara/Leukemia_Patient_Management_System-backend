class UpdatePatientsWithPermanentStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :permanent_status,:boolean, default: false
  end
end
