class UpdateTestWithTestNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :test_notes, :string, default: "No Special Notes"
  end
end
