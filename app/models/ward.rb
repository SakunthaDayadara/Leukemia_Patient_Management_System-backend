class Ward < ApplicationRecord
  has_many :beds, dependent: :destroy, foreign_key: 'ward_num', primary_key: 'ward_num'
  self.primary_key = 'ward_num'
end
