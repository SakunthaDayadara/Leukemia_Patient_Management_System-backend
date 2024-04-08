class Patient < ApplicationRecord
  has_secure_password
  before_create :generate_patient_id

  self.primary_key = 'patient_id'

  private

  def generate_patient_id
    last_patient = Patient.last
    if last_patient.nil?
      self.patient_id = 'PT001'
    else
      last_id = last_patient.patient_id[2..-1].to_i
      new_id = last_id + 1
      self.patient_id = "PT#{'%03d' % new_id}"
    end
  end

end
