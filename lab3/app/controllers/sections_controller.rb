class SectionsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_course, only: [:new, :create] 
    before_action :set_section, only: [:show, :edit, :update, :destroy]
  
    # GET /courses/:course_id/sections/new
    def new
      @section = @course.sections.new
    end
  
    # POST /courses/:course_id/sections for adding a new section
    def create
      @section = @course.sections.new(section_params)
  
      if @section.save
        redirect_to course_path(@course), notice: 'Section was successfully created.'
      else
        render :new
      end
    end
  
    # GET /sections/:id/edit 
    def edit
      @course = Course.find(params[:course_id])
      @section = Section.find(params[:id])
    end
    
    def show
      @course = Course.find(params[:course_id])
      @section = Section.find(params[:id])
    end

    # PATCH/PUT /sections/:id for editing a section
    def update
      @course = Course.find(params[:course_id])
      if params[:grader].present?
        # The grader parameter has a value
        params[:grader_needed] = params[:grader_needed] - 1
      end
      if @section.update(section_params)
        redirect_to course_section_path(@course, @section), notice: 'Section was successfully updated.'
      else
        render :edit, notice: 'Section was NOT successfully updated.'
      end
    end
  
    # DELETE /sections/:id
    def destroy
        @section = Section.find(params[:id])
        @section.destroy
        redirect_to authenticated_root_path, notice: 'Section was successfully destroyed.'
    end
  
    private

      def set_course
        @course = Course.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound
          redirect_to root_path, notice: 'Course not found!'
      end
  

      def set_section
        @section = Section.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          redirect_to root_path, notice: 'Section not found!'
      end

      def section_params
        params.require(:section).permit(:section_id, :start_time, :end_time, :weekday, :grader_needed, :grader, :start_date, :end_date, :semester_code, :campus, :faculty_email, :course_id)
      end
      
     
  end