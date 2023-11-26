class Evaluation < ApplicationRecord
    belongs_to :student, foreign_key: 'student_email', primary_key: 'student_email'
    belongs_to :instructor, foreign_key: 'faculty_email', primary_key: 'faculty_email'
    validates :student_email, presence: true
    validates :faculty_email, presence: true
end
