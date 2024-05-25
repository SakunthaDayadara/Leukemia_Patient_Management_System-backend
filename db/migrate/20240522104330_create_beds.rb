class CreateBeds < ActiveRecord::Migration[7.0]
  def change
    create_table :beds, id: false do |t|
      t.string :bed_id, primary_key: true, unique: true
      t.string :ward_num, null: false
      t.boolean :is_occupied, default: false
      t.string :patient_id

      t.timestamps
    end

    add_foreign_key :beds, :patients, column: :patient_id, primary_key: :patient_id
    add_foreign_key :beds, :wards, column: :ward_num, primary_key: :ward_num


  end
end
