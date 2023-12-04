class RealApplicationsController < ApplicationController
    # Verify user role before any action
    before_action :authenticate_student!, only: [:new, :edit, :create, :update, :destroy, :choose_sections, :show_section]
    before_action :authenticate_admin!, only: [:approve,:deny, :manage, :show_applicant]

    def manage
      #find application and request for manage.html
      @real_applications = RealApplication.all
      @teacher_requests = Request.all
    end

    def show_applicant
      #find application and student
      @application = RealApplication.find(params[:id])
      @student = Student.find_by(student_email: @application.student_email)
      
      #handle error 
      if @student.nil?
        flash[:alert] = "Student not found."
        redirect_to manage_real_applications_path and return
      end
      
      @informationID = GraderApplication.find_by(student_email: @application.student_email)
      
      #handle case when studnent haven't create any information
      if @informationID
        @times = AvailableTime.where(applications_id: @informationID.id)
        @courses = StudentRequestCourse.where(applications_id: @informationID.id)
      else
        @times = []
        @courses = []
      end
    
      @evaluations = Evaluation.where(student_email: @application.student_email)
    rescue ActiveRecord::RecordNotFound
      #handle error (someone input a wrong id in url)
      flash[:alert] = "Application not found."
      redirect_to manage_real_applications_path
    end
    
    def new
      #create application
       @real_application = RealApplication.new
       @user_applications = RealApplication.where(student_email: current_user.email)
    end
    
    def create
      @user_applications = RealApplication.where(student_email: current_user.email)
      @real_application = RealApplication.new(real_application_params)
      
      #limit user access
      session[:accessed_from_edit] = true
      if Student.exists?(student_email: @real_application.student_email)
        if @real_application.save #create application
          redirect_to show_section_real_application_path(@real_application)
        else
          render :new
        end
      else
        redirect_to courses_path, notice: 'Email address not found in student records.'
      end
    end
    

    def show_section
      # only access the page from edit button
      if session[:accessed_from_edit]
        @real_application = RealApplication.find(params[:id])
        @courses = Course.where(catalog_number: @real_application.course_intrested)
        @sections = @selected_course.sections if @selected_course.present?
        # Reset the session variable
        session[:accessed_from_edit] = nil
      else
        redirect_to courses_path, notice: "Direct access is not allowed."
      end
    end
    
      
    def approve
      @real_application = RealApplication.find(params[:id])
      #update status
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
      #update status
      if @real_application.update(status: 'denied') 
        redirect_to manage_real_applications_path, notice: 'Application denied successfully.'
      else
        redirect_to manage_real_applications_path, notice: 'Failed to deny application.'
      end
    end
    
    
    def choose_section
        #update/choose section to application
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
      session[:accessed_from_edit] = true
      @real_application = RealApplication.find(params[:id])
    end
      
    def update
      #for update page
      session[:accessed_from_edit] = true
      @real_application = RealApplication.find(params[:id])
      if Student.exists?(student_email: real_application_params[:student_email])
        if @real_application.update(real_application_params)
          redirect_to show_section_real_application_path(@real_application), notice: 'Application updated successfully. Please choose a section.'
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
