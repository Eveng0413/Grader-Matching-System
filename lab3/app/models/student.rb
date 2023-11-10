class Student < ApplicationRecord
    self.table_name = "students"
    self.primary_key = 'student_email'

    # Connect with Person
    belongs_to :person, foreign_key: 'student_email', primary_key: 'email'
    has_many :available_times, foreign_key: 'student_email', primary_key: 'student_email', dependent: :destroy
end