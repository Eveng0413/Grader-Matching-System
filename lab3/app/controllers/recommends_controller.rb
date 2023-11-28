class RecommendsController < ApplicationController
  before_action :set_recommend, only: %i[ show edit update destroy ]
  before_action :authenticate_instructor!
  # GET /recommends or /recommends.json
  def index
    @recommends = Recommend.all
  end

  # GET /recommends/1 or /recommends/1.json
  def show
  end

  # GET /recommends/new
  def new
    @recommend = Recommend.new
  end

  # GET /recommends/1/edit
  def edit
  end

  # POST /recommends or /recommends.json
  def create

    choice = params[:recommend][:choice]

    # Create User, Person, and Student only if they don't exist
    user = User.find_or_create_by(email: params[:recommend][:student_email]) do |u|
      u.password = "123456" # Replace with secure password logic
    end

    Person.find_or_create_by(email: params[:recommend][:student_email]) do |p|
      p.first_name = params[:recommend][:student_first_name]
      p.last_name = params[:recommend][:student_last_name]
      p.role = "student"
      p.user_id = user.id
    end

    Student.find_or_create_by(student_email: params[:recommend][:student_email])
    
    # Processing based on the choice
    if choice == 'Future consideration'
      # Process data for future in recommends
      # Logic for option A - Save in Recommends model
       # Find or initialize a new Recommend
      @recommend = Recommend.find_or_initialize_by(recommend_params)

      if @recommend.new_record?
        if @recommend.save
          redirect_to courses_url, notice: "Recommendation was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to courses_url, notice: "The recommendation already exists."
      end
      

    elsif choice == 'Request for upcoming semester'
      # Process data for now in requests
      # Logic for option B - Save in Request model
      # Find or initialize a new Request
      @request = Request.find_or_initialize_by(request_params)

      if @request.new_record?
        if @request.save
          redirect_to courses_url, notice: "Request was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to courses_url, notice: "The request already exists."
      end
    end

  end

  # PATCH/PUT /recommends/1 or /recommends/1.json
  def update
    respond_to do |format|
      if @recommend.update(recommend_params)
        format.html { redirect_to recommend_url(@recommend), notice: "Recommend was successfully updated." }
        format.json { render :show, status: :ok, location: @recommend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recommend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommends/1 or /recommends/1.json
  def destroy
    @recommend.destroy

    respond_to do |format|
      format.html { redirect_to recommends_url, notice: "Recommend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommend
      @recommend = Recommend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def recommend_params
      params.require(:recommend).permit(:student_email, :course_id, :faculty_email)
    end
    
    def request_params
      params.require(:recommend).permit(:student_email, :course_id, :section_id, :faculty_email)
    end
    
end
