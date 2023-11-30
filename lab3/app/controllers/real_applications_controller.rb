class RealApplicationsController < ApplicationController
    before_action :authenticate_student!, only: [:new, :edit, :create, :update, :destroy, :select_sections]
    before_action :authenticate_admin!, only: [:approve,:denied]
    def new
       @real_application = RealApplication.new
    end
    
    def create
        @user_applications = RealApplication.where(student_email: current_user.email)
        @real_application = RealApplication.new(real_application_params)
        if Student.exists?(student_email: @real_application.student_email)
            if @real_application.save
              redirect_to real_application_path(@real_application)
            else
              render :new
            end
          else
            redirect_to courses_path, notice: 'Email address not found in student records.'
          end
    end

    def show
        @real_application = RealApplication.find(params[:id])
        @courses = Course.where(catalog_number: @real_application.course_intrested)
        @sections = @selected_course.sections if @selected_course.present?
    end
      
    def approve
        @real_application.update(status: 'approved')
        redirect_to courses_path
    end
      
    def deny
        @real_application.update(status: 'approved')
        redirect_to courses_path
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

    private
    
    def real_application_params
        params.require(:real_application).permit(:student_email, :course_intrested, :section_intrested, :status)
    end

    def setApplication
        @real_application = RealApplication.find_by!(student_email: current_user.email)
    end 
end
