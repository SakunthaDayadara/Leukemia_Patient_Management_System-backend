class ChangeNurseIdInAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :appointments, :nurse_id, false
  end
end
