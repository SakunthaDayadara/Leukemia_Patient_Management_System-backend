class Doctor < ApplicationRecord
  has_secure_password
  before_create :generate_doctor_id

  self.primary_key = 'doctor_id'

  private

  def generate_doctor_id
    last_doctor = Doctor.last
    if last_doctor.nil?
      self.doctor_id = 'DC0001'
    else
      last_id = last_doctor.doctor_id[2..-1].to_i
      new_id = last_id + 1
      self.doctor_id = "DC#{'%04d' % new_id}"
    end
  end
end
