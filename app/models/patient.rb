class Patient < ApplicationRecord
  has_secure_password

  self.primary_key = 'patient_id'

end
