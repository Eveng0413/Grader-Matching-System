# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      if resource.persisted? # if user sign up successfully
        @person = Person.create!( # Write data in person table
          user_id: resource.id,
          email: resource.email, 
          first_name: params[:first_name], 
          last_name: params[:last_name],
          role: 'student'
        )
      end
        #Send request if necessary
        if ['instructor', 'admin'].include?(params[:role])
          RoleRequest.create!(
            email: resource.email,
            role_requested: params[:role],
            status: 'pending' 
          )
        end
    end
  end
  
  # GET /resource/edit
  # def edit
  #   super
  # end

  #PUT /resource
  # def update
  #   super
  # end

  #This method is for edit student ifnfo
  def update
    person_attributes = params.require(:user).permit(:first_name, :last_name, :role)
    params[:user].delete(:first_name)
    params[:user].delete(:last_name)
    #Send request if necessary
    if ['instructor', 'admin'].include?(params[:role])
      request = RoleRequest.find_by(email: resource.email)
      if !request
        # Create a new RoleRequest if it doesn't exist
        RoleRequest.create!(
          email: resource.email,
          role_requested: params[:role],
          status: 'pending' 
        )
      else 
        # Modify the data for the existing RoleRequest
        
        request.update(
          role_requested: params[:role],
          status: 'pending'
        )
        
          
      end
    end

    super do |resource|
      if resource.errors.empty? 
        
        person = resource.person || Person.new(user: resource)
        unless person.update(person_attributes)
          
          person.errors.each do |attr, msg|
            resource.errors.add(attr, msg)
          end
          break 
        end
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # Extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   Rails.logger.info
  #   person = resource.person
  #   if person && person.role == "student"
  #     session[:registered_student_email] = person.email
  #     student_information_path
  #   else
  #     super
  #   end

  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
