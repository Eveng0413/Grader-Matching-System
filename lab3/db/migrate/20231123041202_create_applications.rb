class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :student_email, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
    add_index :applications, :student_email, unique: true
    add_foreign_key :applications, :students, column: :student_email, primary_key: "student_email"
  end
end
