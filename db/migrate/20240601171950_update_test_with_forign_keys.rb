class UpdateTestWithForignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tests, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :tests, :doctors, column: :doctor_id, primary_key: :doctor_id
    add_foreign_key :tests, :nurses, column: :nurse_id, primary_key: :nurse_id
  end
end
