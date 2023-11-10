class AddCourseCourseDiscription < ActiveRecord::Migration[7.0]
  def change
    # Add a new column course_discription in courses
    add_column :courses, :course_discription, :string
  end
end
