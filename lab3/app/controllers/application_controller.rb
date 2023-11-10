class ApplicationController < ActionController::Base
    include Pagy::Backend

    protect_from_forgery with: :exception
  
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected

    #This part insures user and person must have save data
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
  end
  