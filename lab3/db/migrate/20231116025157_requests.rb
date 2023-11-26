class Requests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :student_email, null: false
      t.string :faculty_email, null: false

      t.integer :course_id, null: false
      t.integer :section_id

      t.string :status, default: 'pending', null: false

      t.timestamps
    end
    add_index :requests, [:student_email, :faculty_email, :course_id], unique: true
  end
end
