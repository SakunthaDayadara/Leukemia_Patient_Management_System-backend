class Reference < ApplicationRecord

  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :doctor, foreign_key: 'doctor_id'

  self.primary_key = 'reference_id'

  before_create :generate_reference_id

  private

  def generate_reference_id
    last_reference = Reference.last
    if last_reference.nil?
      self.reference_id = 'RF000001'
    else
      last_id = last_reference.reference_id[2..-1].to_i
      new_id = last_id + 1
      self.reference_id = "RF#{'%06d' % new_id}"
    end
  end
end
