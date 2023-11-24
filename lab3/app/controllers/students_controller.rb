class StudentsController < ApplicationController

    before_action :set_student, only: [:show, :edit, :update, :destroy, :setapplication,:updateapplication]
    def set_student
      student_email = params[:student_email]
      @student = Student.find_by(student_email: student_email)
      unless @student
        flash[:alert] = "Student not found!"
        redirect_to(root_path) 
      end
    end
  

    # This is for lab3
    
    def setapplication
      phone_number = params[:phone_number]
      time_entries = params[:available_times].values
      course_entries = params[:courses].values
    
      valid_time_entries = 0
      valid_course_entries = 0
    
      ActiveRecord::Base.transaction do

        application = GraderApplication.create!(student_email: @student.student_email )

        @student.update!(phone_number: phone_number)

        # Process time entries
        time_entries.each do |time_entry|
          next unless time_entry_valid?(time_entry)
    
          application.available_times.create!(time_entry)
          valid_time_entries += 1
        end
    
        # Process course entries
        course_entries.each do |course_entry|
          next if course_entry[:name].blank?
    
          application.student_request_courses.create!(courseName: course_entry[:name])
          valid_course_entries += 1
        end
      end
    
      handle_redirection(valid_time_entries, valid_course_entries)
    end
    
    def updateapplication
      @grader_application = GraderApplication.find_by(student_email: @student.student_email)
    end

    private
    
    def update_available_times(application, time_entries)
      application.available_times.each do |available_time|
        matching_entry = time_entries.find { |te| te[:id] == available_time.id.to_s }
        available_time.update!(matching_entry) if matching_entry.present?
      end
    end
    
    def update_student_request_courses(application, course_entries)
      application.student_request_courses.each do |course|
        matching_entry = course_entries.find { |ce| ce[:id] == course.id.to_s }
        course.update!(courseName: matching_entry[:courseName]) if matching_entry.present?
      end
    end
    

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
