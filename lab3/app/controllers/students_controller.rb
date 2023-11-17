class StudentsController < ApplicationController

    before_action :set_student, only: [:show, :edit, :update, :destroy, :setgpa,:settime]
    def set_student
      student_email = params[:student_email]
      @student = Student.find_by(student_email: student_email)
      unless @student
        flash[:alert] = "Student not found!"
        redirect_to(root_path) 
      end
  end
  

    # This is for lab3
    # def settime
    #   # Log the student's email for debugging purposes
    #   logger.debug "f #{@student.student_email}"
    
    #   # Retrieve the time entries from the form parameters
    #   time_entries = params[:available_times].values
    
    #   # Counter for the number of valid entries
    #   valid_entries = 0
    #   valid_course_entries = 0

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
      
    #   course_entries.each do |course_entry|
    #     next if course_entry[:name].blank?
    #     @student.student_request_courses.create!(course_name: course_entry[:name])
    #     valid_course_entries += 1
    #   end

    #   # Check if any valid entries were processed
    #   if valid_entries > 0
    #     # If valid entries were added, redirect to a desired path with a success message
    #     flash[:notice] = "#{valid_entries} time slot(s) successfully added."
    #     redirect_to courses_path
    #   else
    #     # If no valid entries, render the current form again with a warning message
    #     flash.now[:alert] = "Please provide at least one complete time slot."
    #     redirect_to student_information_path 
    #   end
    # end
    
    def settime
      logger.debug "f #{@student.student_email}"
    
      time_entries = params[:available_times].values
      course_entries = params[:courses].values
    
      valid_time_entries = 0
      valid_course_entries = 0
    
      ActiveRecord::Base.transaction do
        # Process time entries
        time_entries.each do |time_entry|
          next unless time_entry_valid?(time_entry)
    
          @student.available_times.create!(time_entry)
          valid_time_entries += 1
        end
    
        # Process course entries
        course_entries.each do |course_entry|
          next if course_entry[:name].blank?
    
          @student.student_request_courses.create!(courseName: course_entry[:name])
          valid_course_entries += 1
        end
      end
    
      handle_redirection(valid_time_entries, valid_course_entries)
    end
    
    private
    
    # Validate the time entry
    def time_entry_valid?(time_entry)
      time_entry.is_a?(Hash) && 
      time_entry[:start_time].present? && 
      time_entry[:end_time].present? && 
      time_entry[:weekday].present?
    end
    
    # Handle redirection logic
    def handle_redirection(valid_time_entries, valid_course_entries)
      if valid_time_entries > 0 || valid_course_entries > 0
        flash[:notice] = "#{valid_time_entries} time slot(s) and #{valid_course_entries} course(s) successfully added."
        redirect_to courses_path
      else
        flash.now[:alert] = "Please provide at least one complete time slot or course."
        render :settime # Or redirect to an appropriate path
      end
    end
    
end
