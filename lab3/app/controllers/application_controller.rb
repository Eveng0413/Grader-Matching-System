class ApplicationController < ActionController::Base
    include Pagy::Backend
    helper_method :admin?
    helper_method :instructor?
    helper_method :student?  

    protect_from_forgery with: :exception
  
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected

    #This part insures user and person must have save data
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end

    private

    def admin?
      current_user && current_user.person.role == 'admin'
    end

    def instructor?
      current_user && current_user.person.role == 'instructor'
    end

    def student?
      current_user && current_user.person.role == 'student'
    end

    def authenticate_admin!
      redirect_to courses_path, alert: "You are not authorized to access this page." unless admin?
    end

    def authenticate_instructor!
      redirect_to courses_path, alert: "You are not authorized to access this page." unless instructor?
    end

    def authenticate_student!
      redirect_to courses_path, alert: "You are not authorized to access this page." unless student?
    end
  end
  