class Test < ApplicationRecord
  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :doctor, foreign_key: 'doctor_id'
  belongs_to :nurse, foreign_key: 'nurse_id', optional: true

  before_create :generate_test_id

  self.primary_key = 'test_id'

  private

  def generate_test_id
    last_test = Test.last
    if last_test.nil?
      self.test_id = 'TS000001'
    else
      last_id = last_test.test_id[2..-1].to_i
      new_id = last_id + 1
      self.test_id = "TS#{'%06d' % new_id}"
    end
  end

end
