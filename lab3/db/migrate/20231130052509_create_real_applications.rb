class CreateRealApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :real_applications do |t|
      t.string :student_email
      t.string :course_intrested
      t.string :section_intrested

      t.timestamps
    end
  end
end
