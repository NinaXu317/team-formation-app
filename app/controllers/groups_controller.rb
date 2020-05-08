class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :move, :vote]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @students = @group.students
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        course = Course.find(params[:group][:course_id].to_i)
        @room = Course.find_by(params[:course_id])
        RoomChannel.broadcast_to @room, {commit: 'addCard', payload: render_to_string(:show, formats: [:json])}
        format.html { redirect_to course, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

 

  
  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    @group.update(group_params)
    @room = Course.find_by(params[:course_id])
    RoomChannel.broadcast_to @room, { commit: 'moveCard', payload: render_to_string(:show, formats: [:json]) }
    render action: :show
  end

  def vote
    @group.update(group_params)
    @room = Course.find_by(params[:course_id])
    RoomChannel.broadcast_to @room, { commit: 'vote', payload: render_to_string(:show, formats: [:json]) }
    render action: :show
  end 
  

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { render :show}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:course_id, :project_name, :description, :position, :vfirst, :vsecond, :vthird, :active)
    end
end
