class AvailableTime < ApplicationRecord
    self.table_name = "available_times"
    belongs_to :grader_application, class_name: 'GraderApplication', foreign_key: 'applications_id', primary_key: 'id'

end