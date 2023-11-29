class ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :edit, :update, :destroy]
  
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
    end
  
    def deny
    end
  
    private
  
    def set_application
      @application = GraderApplication.find(params[:id])
    end
  
    def application_params
      params.require(:application).permit()
    end
  end
  