class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    @objective_id = params[:objective_id]

  end

  # GET /goals/1/edit
  def edit
    @objective_id = params[:objective_id]
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    @goal.progress = 0

    respond_to do |format|
      if @goal.save
        format.html { redirect_to editobjective_path(objective_id: @goal.objective_id), notice: "Meta criada com sucesso" }
        format.json { render :show, status: :created, location: @goal }
      else
        @objective_id = params[:goal][:objective_id]
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to editobjective_path(objective_id: @goal.objective_id), notice: "Meta atualizada com sucesso" }
        format.json { render :show, status: :ok, location: @goal }
      else
        @objective_id = params[:goal][:objective_id]
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to editobjective_path(objective_id: @goal.objective_id), notice: "Meta excluída com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:name, :progress, :objective_id)
    end
end
