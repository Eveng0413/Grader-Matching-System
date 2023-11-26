class ChangeForeignKeyInStudentRequestCourses < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :student_request_courses, :students
    remove_column :student_request_courses, :student_email, :string
    add_column :student_request_courses, :applications_id, :integer
    add_foreign_key :student_request_courses, :applications, column: :applications_id
    add_index :student_request_courses, :applications_id
  end
end
