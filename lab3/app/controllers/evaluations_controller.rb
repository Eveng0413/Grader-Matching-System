class EvaluationsController < ApplicationController
    before_action :authenticate_instructor!
    def create
        @evaluation = Evaluation.new(evaluation_params)
    
        if @evaluation.save
          # Redirect to a success page or show a success message
          redirect_to courses_path, notice: 'Evaluation was successfully created.'
        else
          # Render the form again with error messages
          flash.now[:alert] = 'Please ensure you have entered the correct student email.'
          render 'new' 
        end
    end
    
      private
    
    def evaluation_params
        params.require(:evaluation).permit(:student_email, :course_name, :rate, :description, :faculty_email)
    end
end
