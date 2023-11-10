class Person < ApplicationRecord
    belongs_to :user
    self.table_name = "persons"
    VALID_ROLES = ["student", "instructor", "admin"]
    validates :role, inclusion: { in: VALID_ROLES }

    #For lab3
    after_create :create_student_record, if: :student?

    def student?
        role == "student"
    end

    private
    #for lab3 
    def create_student_record

      Student.create!(person: self, student_email: self.email)
      
    end
    has_many :instructors, foreign_key: 'faculty_email', primary_key: 'email'
end