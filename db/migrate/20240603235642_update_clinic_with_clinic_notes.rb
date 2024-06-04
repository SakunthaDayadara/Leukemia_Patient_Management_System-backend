class UpdateClinicWithClinicNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :clinics, :clinic_notes, :string, default: "No Special Notes"

  end
end
