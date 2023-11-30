class RenameCourseNameToCatnumInStudentRequestCourses < ActiveRecord::Migration[7.0]
  def change
    rename_column :student_request_courses, :courseName, :catalog_number
  end
end
