
class Course < ApplicationRecord
    self.table_name = "courses"
    has_many :sections
    #Use for display options in recommends form
    def catalog_number_and_course_name
        "#{catalog_number} - #{course_name}"
    end
end