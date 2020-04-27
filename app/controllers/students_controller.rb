class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :vote]

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
    @student = Student.find(params[:id])
    @student_id = params[:id]
  end

  #POST /students/1/search_course
  def search_course
    @student = Student.find(params[:id])
    course = Course.where(pin: params[:pin]).take
    puts "Student: " + @student.inspect
    puts "Course: " + course.inspect
    if course.nil?
      redirect_to @student, notice: "There is no course with that pin" and return
    end

    if Taking.where(student_id: params[:id], course_id: course.id).size == 0
      @taking = Taking.create(student_id: params[:id], course_id: course.id)
    else
      redirect_to @student, notice: "You are already registered for this course" and return
    end

    redirect_to @student, notice: "Course added!"
  end

  #POST /students/1/drop_course






  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        log_in(@student, "student")
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
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
