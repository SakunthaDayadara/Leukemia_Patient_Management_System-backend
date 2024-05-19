class Appointment < ApplicationRecord
  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :nurse, foreign_key: 'nurse_id', optional: true
  before_create :generate_appointment_id


  self.primary_key = 'appointment_id'


  private

  def generate_appointment_id
    last_appointment = Appointment.last
    if last_appointment.nil?
      self.appointment_id = 'AP000001'
    else
      last_id = last_appointment.appointment_id[2..-1].to_i
      new_id = last_id + 1
      self.appointment_id = "AP#{'%06d' % new_id}"
    end
  end

end
