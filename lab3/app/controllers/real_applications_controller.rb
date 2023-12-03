class RealApplicationsController < ApplicationController
    before_action :authenticate_student!, only: [:new, :edit, :create, :update, :destroy, :choose_sections, :show_section]
    before_action :authenticate_admin!, only: [:approve,:deny, :manage, :show_applicant]
    def manage
      @real_applications = RealApplication.all
      @teacher_requests = Request.all
    end

    def show_applicant
      @application = RealApplication.find(params[:id])
      @student = Student.find_by(student_email: @application.student_email)
    
      if @student.nil?
        flash[:alert] = "Student not found."
        redirect_to manage_real_applications_path and return
      end
    
      @informationID = GraderApplication.find_by(student_email: @application.student_email)
      
      if @informationID
        @times = AvailableTime.where(applications_id: @informationID.id)
        @courses = StudentRequestCourse.where(applications_id: @informationID.id)
      else
        @times = []
        @courses = []
      end
    
      @evaluations = Evaluation.where(student_email: @application.student_email)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Application not found."
      redirect_to manage_real_applications_path
    end
    
    def new
       @real_application = RealApplication.new
       @user_applications = RealApplication.where(student_email: current_user.email)
    end
    
    def create
      @user_applications = RealApplication.where(student_email: current_user.email)
      @real_application = RealApplication.new(real_application_params)
      
      if Student.exists?(student_email: @real_application.student_email)
        if @real_application.save
          redirect_to show_section_real_application_path(@real_application)
        else
          render :new
        end
      else
        redirect_to courses_path, notice: 'Email address not found in student records.'
      end
    end
    

    def show_section
        @real_application = RealApplication.find(params[:id])
        @courses = Course.where(catalog_number: @real_application.course_intrested)
        @sections = @selected_course.sections if @selected_course.present?
    end
      
    def approve
      @real_application = RealApplication.find(params[:id])
      if @real_application.update(status: 'approved')
        if @real_application.section_intrested.present?
          section = Section.find_by(s_id: @real_application.section_intrested)
          if section
            # Reduce the grader needed count if applicable
            section.update(grader_needed: section.grader_needed - 1) if section.grader_needed > 0
            
            # Append student email to grader string
            if section.grader.blank?
              section.grader = @real_application.student_email
            else
              section.grader += ", " + @real_application.student_email
            end
            section.save
          end
        end
        redirect_to manage_real_applications_path, notice: 'Application approved successfully.'
      else
        redirect_to manage_real_applications_path, notice: 'Failed to approve application.'
      end
    end
      
    def deny
      @real_application = RealApplication.find(params[:id])
      if @real_application.update(status: 'denied')
        redirect_to manage_real_applications_path, notice: 'Application denied successfully.'
      else
        redirect_to manage_real_applications_path, notice: 'Failed to deny application.'
      end
    end
    
    
    def choose_section
        @real_application = RealApplication.find(params[:real_application_id])
        @section = Section.find(params[:section_id])
      
        if @real_application && @section
          @real_application.update(section_intrested: @section.id)
          redirect_to courses_path, notice: 'Section chosen successfully.'
        else
          redirect_to courses_path, notice: 'Failed to choose section.'
        end
    end

    def edit
      @real_application = RealApplication.find(params[:id])
    end
      
    def update
      @real_application = RealApplication.find(params[:id])
      if Student.exists?(student_email: real_application_params[:student_email])
        if @real_application.update(real_application_params)
          redirect_to real_application_path(@real_application), notice: 'Application updated successfully. Please choose a section.'
        else
          render :edit
        end
      else
        redirect_to courses_path, notice: 'Email address not found in student records.'
      end
    end 


    private
    
    def real_application_params
        params.require(:real_application).permit(:student_email, :course_intrested, :section_intrested, :status, :time_intrested)
    end

    def setApplication
        @real_application = RealApplication.find_by!(student_email: current_user.email)
    end 
end
