class AddTelephoneToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :telephone, :string
  end
end
