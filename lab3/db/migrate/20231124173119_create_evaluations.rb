class CreateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.string :student_email
      t.string :faculty_email
      t.string :course_name
      t.integer :rate
      t.text :description

      t.timestamps
    end
    add_index :evaluations, :student_email
    add_index :evaluations, :faculty_email
  end
end
