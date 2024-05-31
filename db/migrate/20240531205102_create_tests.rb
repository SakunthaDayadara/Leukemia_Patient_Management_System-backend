class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests, id: false do |t|
      t.string :test_id, primary_key: true, unique: true
      t.string :test_type
      t.string :test_status, default: 'requested'
      t.date :test_date
      t.string :test_place
      t.date :report_date
      t.string :report_url
      t.string :nurse_id
      t.string :patient_id, null: false
      t.string :doctor_id, null: false

      t.timestamps
    end
  end
end
