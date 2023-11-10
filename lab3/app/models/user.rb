class User < ApplicationRecord
  has_one :person, class_name: 'Person'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validate :email_domain_check

         private
        
         def isNumber(input)
          number_regex = /\A[-+]?\d+(\.\d+)?\z/
          if input[0].match?(number_regex)
            return true
          else
            return false
          end
         end

         def email_domain_check
           return if email.blank?  # Check if user have enter the email
           email_part = email.split('.')
           domain = email_part.last
           email_length = email_part.length
           errors.add(:email, " must be last.number@osu.edu ") unless domain == "edu" && email.include?("@osu.") && email_length == 3 && isNumber(email_part[1].split('@'))
         end
end
