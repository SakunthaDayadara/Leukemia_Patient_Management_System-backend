class Admin < ApplicationRecord
  has_secure_password
  before_create :generate_admin_id

  self.primary_key = 'admin_id'

  private

  def generate_admin_id
    last_admin = Admin.last
    if last_admin.nil?
      self.admin_id = 'AD0001'
    else
      last_id = last_admin.admin_id[2..-1].to_i
      new_id = last_id + 1
      self.admin_id = "AD#{'%04d' % new_id}"
    end
  end
end
