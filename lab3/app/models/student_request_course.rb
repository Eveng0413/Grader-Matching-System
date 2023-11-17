class StudentRequestCourse < ApplicationRecord
    belongs_to :student, foreign_key: 'student_email', primary_key: 'student_email'
end
