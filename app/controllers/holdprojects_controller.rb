class HoldprojectsController < ApplicationController
  before_action :set_holdproject, only: [:show, :edit, :update, :destroy, :move]

  # GET /holdprojects
  # GET /holdprojects.json
  def index
    @holdprojects = Holdproject.all
  end

  # GET /holdprojects/1
  # GET /holdprojects/1.json
  def show
  end

  # GET /holdprojects/new
  def new
    @holdproject = Holdproject.new
  end

  # GET /holdprojects/1/edit
  def edit
  end

  # POST /holdprojects
  # POST /holdprojects.json
  def create
    @holdproject = Holdproject.new(holdproject_params)

    respond_to do |format|
      if @holdproject.save
        format.html { redirect_to @holdproject, notice: 'Holdproject was successfully created.' }
        format.json { render :show, status: :created, location: @holdproject }
      else
        format.html { render :new }
        format.json { render json: @holdproject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holdprojects/1
  # PATCH/PUT /holdprojects/1.json
  def update
    respond_to do |format|
      if @holdproject.update(holdproject_params)
        format.html { redirect_to @holdproject, notice: 'Holdproject was successfully updated.' }
        format.json { render :show, status: :ok, location: @holdproject }
      else
        format.html { render :edit }
        format.json { render json: @holdproject.errors, status: :unprocessable_entity }
      end
    end
  end


  def move
    @holdproject.insert_at(holdproject_params[:position].to_i)
    render action: :show
  end
    
  # DELETE /holdprojects/1
  # DELETE /holdprojects/1.json
  def destroy
    @holdproject.destroy
    respond_to do |format|
      format.html { redirect_to holdprojects_url, notice: 'Holdproject was successfully destroyed.' }
      format.json { render :show }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holdproject
      @holdproject = Holdproject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def holdproject_params
      params.require(:holdproject).permit(:course_id, :project_name, :position, :description)
    end
end
