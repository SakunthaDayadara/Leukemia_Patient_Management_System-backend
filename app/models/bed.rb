class Bed < ApplicationRecord
  belongs_to :ward, foreign_key: 'ward_num', primary_key: 'ward_num'
  belongs_to :patient, optional: true

  self.primary_key = 'bed_id'


end
