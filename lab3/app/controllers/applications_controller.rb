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
  
    def update
      if @application.update(application_params)
        redirect_to @application, notice: 'Application was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @application.destroy
      redirect_to applications_url, notice: 'Application was successfully destroyed.'
    end
  
    private
  
    def set_application
      @application = GraderApplication.find(params[:id])
    end
  
    def application_params
      params.require(:application).permit(:name, :description, :version)
    end
  end
  