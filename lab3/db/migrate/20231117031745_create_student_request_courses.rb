class CreateStudentRequestCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :student_request_courses do |t|
      t.string :student_email, null: false
      t.string :courseName

      t.timestamps
    end
    add_foreign_key :student_request_courses, :students, column: :student_email, primary_key: :student_email
  end
end
