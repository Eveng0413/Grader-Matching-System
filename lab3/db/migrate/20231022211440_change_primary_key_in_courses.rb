class ChangePrimaryKeyInCourses < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :sections, :courses
    # Remove the primary key constraint from course_id
    change_column :courses, :course_id, :integer, primary_key: false

    # Add a new column c_id and make it the primary key
    add_column :courses, :c_id, :integer, primary_key: true, auto_increment: true
  end
end
