class AvailableTime < ApplicationRecord
    self.table_name = "available_times"
    belongs_to :student, foreign_key: 'student_email', primary_key: 'student_email' 
end