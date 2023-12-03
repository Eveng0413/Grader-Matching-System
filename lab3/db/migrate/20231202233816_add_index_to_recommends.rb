class AddIndexToRecommends < ActiveRecord::Migration[7.0]
  def change
    # Add a primary key column
    add_column :recommends, :id, :primary_key

    # Then add the unique index
    add_index :recommends, [:student_email, :faculty_email, :course_id], unique: true, name: 'index_recommends_on_student_email_faculty_email_course_id'
  end
end
