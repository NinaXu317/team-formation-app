require 'poro/Matching'
require 'poro/RandomMatching'
require 'poro/ProjectMatching'
require 'poro/HolisticMatching'

require 'services/group_creation_service'
require 'services/error_service'

class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  include CoursesHelper
  
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if params[:teams].nil?
      @teams = {}
    else
      @teams = params[:teams]
    end

    @professor = @course.professor
    if !@professor.nil?
      @professor_id = @professor.id
    else
      @professor_id = nil
    end
    @preferences = @course.preferences
    @groups = @course.groups
  end

  #POST /courses/1/create_groups
  def create_groups
    group_service = GroupCreationService.new
    error_service = ErrorService.new
    @course = Course.find(params[:id])

    errors = error_service.handle_group_creation_errors(@course)

    if errors.size > 0
      redirect_to @course, notice: "Group Creation had the following errors: #{error_service.to_string(errors)}" and return
    end

    group_service.determineAlgorithmAndMatch(@course, params)
    redirect_to @course, notice: "Groups created!"
  end

  # GET /courses/new
  def new
    @course = Course.new
    #@user_id = current_user.id
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.js
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    professor = @course.professor 
    @course.destroy
    respond_to do |format|
      format.html { redirect_to professor, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :pin, :professor_id)
    end
end
