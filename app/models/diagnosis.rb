class Diagnosis < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_one :treatment_plan, primary_key: :diagnose_id, foreign_key: :diagnose_id, dependent: :destroy
  before_create :generate_diagnose_id

  self.primary_key = 'diagnose_id'

  private

  def generate_diagnose_id
    last_diagnosis = Diagnosis.last
    if last_diagnosis.nil?
      self.diagnose_id = 'DG000001'
    else
      last_id = last_diagnosis.diagnose_id[2..-1].to_i
      new_id = last_id + 1
      self.diagnose_id = "DG#{'%06d' % new_id}"
    end
  end


end
