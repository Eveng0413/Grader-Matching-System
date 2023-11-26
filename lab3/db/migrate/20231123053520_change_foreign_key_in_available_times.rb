class ChangeForeignKeyInAvailableTimes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :available_times, :students
    remove_column :available_times, :student_email, :string
    add_column :available_times, :applications_id, :integer
    add_foreign_key :available_times, :applications, column: :applications_id
    add_index :available_times, :applications_id
  end
end
