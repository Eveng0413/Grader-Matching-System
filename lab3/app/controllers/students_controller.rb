class StudentsController < ApplicationController

    before_action :set_student, only: [:show, :update, :destroy, :setInfo]
    before_action :authenticate_student!
    def set_student
      student_email = params[:student_email]
      @student = Student.find_by(student_email: student_email)
      unless @student
        flash[:alert] = "Student not found!"
        redirect_to(root_path) 
      end
    end
  

    # This is for lab3
    
    def delete_all_times
      @user_email = current_user.email
      @grader_info = GraderApplication.find_by(student_email: @user_email)

      if @grader_info.present?
        @grader_info.available_times.destroy_all
        redirect_to student_information_path, notice: 'All time slots have been deleted.'
      else
        redirect_to student_information_path, notice: 'No time slots found to delete.'
      end
    end

    def information
      @user_email = current_user.email
      @grader_info = GraderApplication.find_by(student_email: @user_email)
      @has_info = @grader_info.present?
      @student = Student.find_by(student_email: @user_email)
      @time_slots_count = params[:time_slots_count].to_i > 0 ? params[:time_slots_count].to_i : 15
      @times = @grader_info ? @grader_info.available_times.order(:created_at).limit(@time_slots_count) : []
      
      if @grader_info
        @course_count = params[:course_count].to_i > 0 ? params[:course_count].to_i : @grader_info.student_request_courses.count
      else
        @course_count = params[:course_count].to_i > 0 ? params[:course_count].to_i : 10
      end
    end
    
    def setInfo
      @user_email = current_user.email
      @grader_info = GraderApplication.find_by(student_email: @user_email)

      phone_number = params[:phone_number] || ""  
      time_entries = params[:available_times] ? params[:available_times].values : []
      course_entries = params[:courses] ? params[:courses].values : []
    
      valid_time_entries = 0
      valid_course_entries = 0
    
      ActiveRecord::Base.transaction do
        if @grader_info
          # Update information 
          @grader_info.available_times.destroy_all
          time_entries.each do |time_entry|
            next unless time_entry_valid?(time_entry)
    
            @grader_info.available_times.create!(time_entry)
            valid_time_entries += 1
          end
    
          @grader_info.student_request_courses.destroy_all
          course_entries.each do |course_entry|
            next if course_entry[:name].blank?
    
            @grader_info.student_request_courses.create!(catalog_number: course_entry[:name])
            valid_course_entries += 1
          end
        else
          # Create new information table
          application = GraderApplication.create!(student_email: @student.student_email)
    
          time_entries.each do |time_entry|
            next unless time_entry_valid?(time_entry)
    
            application.available_times.create!(time_entry)
            valid_time_entries += 1
          end
    
          course_entries.each do |course_entry|
            next if course_entry[:name].blank?
    
            application.student_request_courses.create!(catalog_number: course_entry[:name])
            valid_course_entries += 1
          end
        end
  
        @student.update!(phone_number: phone_number)
      end
    
      handle_redirection(valid_time_entries, valid_course_entries)
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
        matching_entry = course_entries.find { |ce| ce[:catalog_number] == course.catalog_number }
        course.update!(catalog_number: matching_entry[:catalog_number]) if matching_entry.present?
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
        redirect_to courses_path
      end
    end
    
end
