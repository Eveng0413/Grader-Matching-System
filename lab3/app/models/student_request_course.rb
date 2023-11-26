class StudentRequestCourse < ApplicationRecord
    belongs_to :grader_application, class_name: 'GraderApplication', foreign_key: 'applications_id', primary_key: 'id'
end
