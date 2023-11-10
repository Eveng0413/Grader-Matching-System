class RoleRequest < ApplicationRecord
    class RoleRequest < ApplicationRecord
        validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }  #must have email
        validates :role_requested, presence: true, inclusion: { in: %w(student admin instructor) }
        validates :status, inclusion: { in: %w(pending done) }   #status only have 2
      end    
end
