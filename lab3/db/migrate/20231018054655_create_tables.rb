class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :persons, id: false do |t|
      t.string :email, primary_key: true
      t.string :first_name
      t.string :last_name
      t.string :role
      t.timestamps
    end

    create_table :students, id: false do |t|
      t.string :student_email, primary_key: true
      t.boolean :is_grader
      t.string :evaluate
      t.float :gpa
      t.foreign_key :persons, column: :student_email, primary_key: :email

      t.timestamps
    end

    create_table :instructors, id: false do |t|
      t.string :faculty_email, primary_key: true
      t.foreign_key :persons, column: :faculty_email, primary_key: :email

      t.timestamps
    end

    create_table :admins, id: false do |t|
      t.string :admin_email, primary_key: true
      t.foreign_key :persons, column: :admin_email, primary_key: :email

      t.timestamps
    end

    create_table :available_times, id: false do |t|
      t.integer :time_id, primary_key: true
      t.time :time
      t.string :weekday
      t.string :student_email
      t.foreign_key :students, column: :student_email, primary_key: :student_email

      t.timestamps
    end

    create_table :courses, id: false do |t|
      t.integer :course_id, primary_key: true
      t.string :course_name
      t.integer :credit_hour
      t.string :academic_career
      t.string :student_email
      t.string :admin_email
      t.foreign_key :students, column: :student_email, primary_key: :student_email
      t.foreign_key :admins, column: :admin_email, primary_key: :admin_email

      t.timestamps
    end

    create_table :sections, id: false do |t|
      t.integer :section_id, primary_key: true
      t.time :start_time
      t.time :end_time
      t.string :weekday
      t.boolean :has_grader
      t.date :start_date
      t.date :end_date
      t.string :semester_code
      t.string :campus
      t.string :faculty_email
      t.integer :course_id
      t.foreign_key :instructors, column: :faculty_email, primary_key: :faculty_email
      t.foreign_key :courses, column: :course_id

      t.timestamps
    end

    create_table :student_grade_sections, id: false do |t|
      t.string :student_email
      t.string :faculty_email
      t.string :admin_email
      t.foreign_key :students, column: :student_email, primary_key: :student_email
      t.foreign_key :instructors, column: :faculty_email, primary_key: :faculty_email
      t.foreign_key :admins, column: :admin_email, primary_key: :admin_email

      t.timestamps
    end

    create_table :recommends, id: false do |t|
      t.string :student_email
      t.string :faculty_email
      t.string :admin_email
      t.foreign_key :students, column: :student_email, primary_key: :student_email
      t.foreign_key :instructors, column: :faculty_email, primary_key: :faculty_email
      t.foreign_key :admins, column: :admin_email, primary_key: :admin_email

      t.timestamps
    end
  end
end
