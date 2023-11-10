class Section < ApplicationRecord
    self.table_name = "sections"
    belongs_to :instructor, foreign_key: 'faculty_email', class_name: 'Instructor'
end