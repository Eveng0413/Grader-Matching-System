class GraderApplication < ApplicationRecord
    
    has_many :available_times, foreign_key: 'applications_id',dependent: :destroy
    has_many :student_request_courses, foreign_key: 'applications_id', primary_key: 'id', dependent: :destroy
    validates :student_email, presence: true

end
