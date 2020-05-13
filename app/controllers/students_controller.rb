class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :add_course, :drop_course, :search_course]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @courses = @student.courses
    @groups = @student.groups
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @courses = @student.courses.all
  end

  #GET /students/1/add_course
  def add_course
    @student_id = params[:id]
  end

  #POST /students/1/search_course
  def search_course
    registrar = EnrollmentManager::Registrar.new
    registrar_notice = registrar.enroll_in_course(@student.id, params[:pin])
    redirect_to @student, notice: registrar_notice 
  end

  #DELETE /students/1/drop_course?course=1
  def drop_course
    registrar = EnrollmentManager::Registrar.new
    registrar.drop_course(params[:student_id], params[:course_id])
    respond_to do |format|
      format.html { redirect_to @student, notice: 'Class was dropped.' }
      format.json { head :no_content }
    end
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      @student.activated = true
      if @student.save
        # @student.activated = true
        log_in(@student, "student")
        
        format.html { redirect_to root_url}
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:firstname, :password, :password_confirmation, :lastname, :email, :Vfirst, :Vsecond, :Vthird, courses_attributes: [:id, :name, :_destroy])
    end
end
