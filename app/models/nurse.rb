class Nurse < ApplicationRecord
  belongs_to :ward, foreign_key: 'ward_num'
  has_many :treatment_records, foreign_key: 'nurse_id'
  has_secure_password
  before_create :generate_nurse_id

  self.primary_key = 'nurse_id'

  private

  def generate_nurse_id
    last_nurse = Nurse.last
    if last_nurse.nil?
      self.nurse_id = 'NU0001'
    else
      last_id = last_nurse.nurse_id[2..-1].to_i
      new_id = last_id + 1
      self.nurse_id = "NU#{'%04d' % new_id}"
    end
  end
end
