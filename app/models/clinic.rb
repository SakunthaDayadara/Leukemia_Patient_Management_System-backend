class Clinic < ApplicationRecord
  belongs_to :doctor, foreign_key: 'doctor_id'
  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :nurse, foreign_key: 'nurse_id', optional: true

  before_create :generate_clinic_id

  self.primary_key = 'clinic_id'

  private

  def generate_clinic_id
    last_clinic = Clinic.last
    if last_clinic.nil?
      self.clinic_id = 'CL000001'
    else
      last_id = last_clinic.clinic_id[2..-1].to_i
      new_id = last_id + 1
      self.clinic_id = "CL#{'%06d' % new_id}"
    end
  end

end
