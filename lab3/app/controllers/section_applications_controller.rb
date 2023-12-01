 # author Yiheng Zhou
class SectionApplicationsController < ApplicationController

    def show
        @user = current_user ;
        @person = Person.find(@user.email);
        @sid = params[:id]
        @section = Section.find(params[:id]);
        @applicationList = SectionApplication.where(section_id: @section.section_id)
    end

    def new
        @user = current_user ;
        @person = Person.find(@user.email);
        @section = Section.find(params[:id]);
        @section_applications = SectionApplication.new;
        @section_applications.email = @person.email;
        @section_applications.section_id = @section.section_id;
        @section_applications.course_id = @section.course_id;
        @section_applications.last_name = @person.last_name;
        @section_applications.first_name = @person.first_name;
        @section_applications.flag= 0;
    end

    def create
        @user = current_user ;
        if SectionApplication.where(email: @user.email,section_id:section_application_params[:section_id]).exists?
            redirect_to '/', notice: 'application was NOT successfully created.'
            return;
        end
        

        @section_applications = SectionApplication.new(section_application_params)
        @section_applications.flag = 0; 
        if @section_applications.save
            redirect_to '/', notice: 'Application was successfully created.'
        else
            redirect_to '/', notice: 'application was NOT successfully created.'
        end 
    end

    def delete
        @obj = SectionApplication.find(params[:id])
        @obj.destroy
        redirect_to '/section/applications/list/'+params[:sid], notice: 'application was successfully deleted.'
    end

    def check
        @obj = SectionApplication.find(params[:id])
        @obj.flag= 1;
        @obj.save
        
        redirect_to '/section/applications/list/'+params[:sid], notice: 'application was successfully update flag.'
    end

    private
        def section_application_params
            params.require(:section_application).permit(:course_id, :section_id, :email, :first_name, :last_name, :interests)
        end
end
