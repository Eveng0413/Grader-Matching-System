class StudentsController < ApplicationController

    before_action :set_student, only: [:show, :edit, :update, :destroy, :setgpa,:settime]
    def set_student
        student_email = session[:registered_student_email]
        @student = Student.find_by(student_email: student_email)
    
        # If cannot find student
        unless @student
          flash[:alert] = "Student not found!"
          redirect_to(root_path) 
        end
    end

    # def setgpa
    #     new_gpa = params[:gpa]
    #     if @student.update(gpa: new_gpa)
    #       flash[:notice] = "GPA Update！"
    #     else
    #       flash.now[:alert] = "Faile to Update"
    #     end
    #   end

    # This is for lab3
    # def settime
    #   # Log the student's email for debugging purposes
    #   logger.debug "Current student email: #{@student.student_email}"
    
    #   # Retrieve the time entries from the form parameters
    #   time_entries = params[:available_times].values
    
    #   # Counter for the number of valid entries
    #   valid_entries = 0
    
    #   # Iterate over each time entry
    #   time_entries.each do |time_entry|
    #     # Skip this iteration if the time entry isn't a Hash or any critical attribute is blank
    #     next unless time_entry.is_a?(Hash)
    #     next if time_entry[:start_time].blank? || time_entry[:end_time].blank? || time_entry[:weekday].blank?
    
    #     # Create a new available time linked to the current student
    #     @student.available_times.create!(time_entry)
    
    #     # Increment the valid entries counter
    #     valid_entries += 1
    #   end
    
    #   # Check if any valid entries were processed
    #   if valid_entries > 0
    #     # If valid entries were added, redirect to a desired path with a success message
    #     flash[:notice] = "#{valid_entries} time slot(s) successfully added."
    #     redirect_to placeholder_welcome_path 
    #   else
    #     # If no valid entries, render the current form again with a warning message
    #     flash.now[:alert] = "Please provide at least one complete time slot."
    #     redirect_to student_information_path 
    #   end
    # end
    
      
      

end
