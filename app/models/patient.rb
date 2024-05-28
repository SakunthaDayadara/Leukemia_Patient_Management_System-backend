class Patient < ApplicationRecord
  has_secure_password
  before_create :generate_patient_id
  has_one :appointment, dependent: :destroy
  has_one :bed, dependent: :destroy
  has_one :diagnosis, dependent: :destroy
  has_one :treatment_plan, dependent: :destroy
  has_many :treatment_record, dependent: :destroy
  has_many :reference, dependent: :destroy

  self.primary_key = 'patient_id'

  validates :gender, presence: true, inclusion: { in: %w(male female) }

  private

    def generate_patient_id
      last_patient = Patient.last
      if last_patient.nil?
        self.patient_id = 'PT000001'
      else
        last_id = last_patient.patient_id[2..-1].to_i
        new_id = last_id + 1
        self.patient_id = "PT#{'%06d' % new_id}"
      end
    end

end
