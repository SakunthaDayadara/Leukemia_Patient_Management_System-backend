class CreateNurses < ActiveRecord::Migration[7.0]
  def change
    create_table :nurses, id: false do |t|
      t.string :nurse_id, primary_key: true, unique: true
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :ward_num, null: false

      t.timestamps
    end

    add_foreign_key :nurses, :wards, column: :ward_num, primary_key: :ward_num

  end
end
