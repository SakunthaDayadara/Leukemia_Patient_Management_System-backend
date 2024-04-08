class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: false do |t|
      t.string :patient_id, primary_key: true, unique: true
      t.date :dob
      t.string :nic, unique: true
      t.text :address
      t.string :gender
      t.string :username, unique: true
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
