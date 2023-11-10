class RoleRequestsController < ApplicationController
    #before_action :set_role_request
    # def new
    #   @role_requests = RoleRequest.all 
    # end
    def index
      @role_requests = RoleRequest.all  
    end

    # approve for a user account to be a instructor or a admin
    def approve
      @role_request = RoleRequest.find(params[:id]) # Fetch the specific role request by ID
      @person = Person.find(@role_request.email)
      if @role_request.status == 'pending'
        if @role_request.update(status: 'approved')
          @person.update(role: @role_request.role_requested)
          redirect_to role_requests_url, notice: 'Role request was successfully approved.'
        else
          redirect_to role_requests_url, alert: 'Error occurred while approving the role request.'
        end
      else
        redirect_to role_requests_url, alert: 'This role request has already been processed.'
      end
    end
    
    # deny for a user account to be a instructor or a admin
    def deny
      @role_request = RoleRequest.find(params[:id]) # Fetch the specific role request by ID

      if @role_request.status == 'pending'
        if @role_request.update(status: 'denied')
          # If the role request status is 'pending', update it to 'denied'
          redirect_to role_requests_url, notice: 'Role request was successfully denied.'
        else
          redirect_to role_requests_url, alert: 'Error occurred while denying the role request.'
        end
      else
        redirect_to role_requests_url, alert: 'This role request has already been processed.'
      end
    end  
    

    
      private
    
      # Use callbacks to share common setup or constraints between actions.
      def set_role_request
        @role_request = RoleRequest.find(params[:id])
      end
    
      # Only allow a list of trusted parameters through.
      def role_request_params
        params.require(:role_request).permit(:email, :role_requested, :status)
      end
  end
  