class Instructor < ApplicationRecord
    self.table_name = "instructors"
    belongs_to :person, foreign_key: 'faculty_email', primary_key: 'email'
    #Get Instuctor full name
    def full_name
        [person.first_name, person.last_name].join(' ')
    end
end
