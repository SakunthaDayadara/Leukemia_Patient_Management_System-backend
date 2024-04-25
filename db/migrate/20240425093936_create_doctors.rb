class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors, id: false do |t|
      t.string :doctor_id, primary_key: true, unique: true
      t.string :name
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
