class ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :edit, :update, :destroy, :deny, :approve, :assign_grader ]
  
    def index
      @applications = GraderApplication.all
    end
  
    def show
        @student = Person.find_by(email: @application.student_email)
        @name = @student.first_name + " " + @student.last_name 
        
    end
  
  
    def create
    end
  
    def edit
    end
    
    def approve
      @application.update(status: 'approved')
      redirect_to assign_grader_application_path(@application)
    end
  
    def deny
      @application.update(status: 'denied')
      redirect_to courses_path
    end
    
    def assign_grader
          # @application = GraderApplication.find(params[:id])
      @student_request_courses = StudentRequestCourse.where(applications_id: @application.id)
      catalog_numbers = @student_request_courses.pluck(:catalog_number)
      @courses = Course.where(catalog_number: catalog_numbers)
    end
    private
  
    def set_application
      @application = GraderApplication.find(params[:id])
    end
  
    def application_params
      params.require(:application).permit()
    end
  end
  