class TreatmentRecord < ApplicationRecord
  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :nurse, foreign_key: 'nurse_id'
  belongs_to :treatment_plan, foreign_key: 'treatment_id'
  before_create :generate_treatment_record_id

  self.primary_key = 'treatment_record_id'

  private

  def generate_treatment_record_id
    last_treatment_record = TreatmentRecord.last
    if last_treatment_record.nil?
      self.treatment_record_id = 'TR000001'
    else
      last_id = last_treatment_record.treatment_record_id[2..-1].to_i
      new_id = last_id + 1
      self.treatment_record_id = "TR#{'%06d' % new_id}"
    end
  end
end
