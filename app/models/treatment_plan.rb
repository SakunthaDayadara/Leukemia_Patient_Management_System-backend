class TreatmentPlan < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  belongs_to :diagnosis
  before_create :generate_treatment_plan_id


  self.primary_key = 'treatment_id'

  private

  def generate_treatment_plan_id
    last_treatment_plan = TreatmentPlan.last
    if last_treatment_plan.nil?
      self.treatment_id = 'TP000001'
    else
      last_id = last_treatment_plan.treatment_id[2..-1].to_i
      new_id = last_id + 1
      self.treatment_id = "TP#{'%06d' % new_id}"
    end
  end

end