class Student < ApplicationRecord
    self.table_name = "students"
    self.primary_key = 'student_email'

    belongs_to :person, foreign_key: 'student_email', primary_key: 'email'

    has_many :available_times, foreign_key: 'student_email', primary_key: 'student_email', dependent: :destroy

    has_many :student_request_courses, foreign_key: 'student_email', primary_key: 'student_email', dependent: :destroy
end