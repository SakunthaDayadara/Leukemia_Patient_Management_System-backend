class CreateWards < ActiveRecord::Migration[7.0]
  def change
    create_table :wards, id: false  do |t|
      t.string :ward_num, primary_key: true, unique: true
      t.string :patient_gender

      t.timestamps
    end
  end
end
