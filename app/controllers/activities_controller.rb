class ActivitiesController < ApplicationController
  load_and_authorize_resource
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.where(goal_id: params[:goal_id]).order(created_at: :asc)
    @goal_id = params[:goal_id]
    authorize! :index, @activities
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @goal_id = params[:goal_id]
  end

  # GET /activities/1/edit
  def edit
    # Another way to set goal_id
    @goal_id = Activity.find(params[:id]).goal_id
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.checked = false
    goal = Goal.find(params[:activity][:goal_id])
    respond_to do |format|
      if @activity.save
        update_goal_completion(goal.id)
        update_sphere_completion(goal.id)
        format.html {redirect_to editobjective_path(objective_id: goal.objective_id), notice: "Atividade criada com sucesso"}
        format.json {render :show, status: :created, location: @activity}
      else
        @goal_id = goal.id
        format.html {render :new}
        format.json {render json: @activity.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        goal = Goal.find(@activity.goal_id)
        format.html {redirect_to editobjective_path(objective_id: goal.objective_id), notice: "Atividade atualizada com sucesso"}
        format.json {render :show, status: :ok, location: @activity}
      else
        format.html {render :edit, locals: {goal_id: @activity.goal_id}}
        format.json {render json: @activity.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    goal_id = @activity.goal_id
    goal = Goal.find(goal_id)
    @activity.destroy
    update_goal_completion(goal_id)
    update_sphere_completion(goal.id)
    respond_to do |format|
      format.html {redirect_to editobjective_path(objective_id: goal.objective_id), notice: "Atividade foi excluída"}
      format.json {head :no_content}
    end
  end

  def checked
    goal = Goal.find(params[:goal_id])
    goal.activities.where.not(id: params[:activity_ids]).update_all(checked: false)
    Activity.where(id: params[:activity_ids]).update_all(checked: true)
    update_goal_completion(params[:goal_id])
    update_sphere_completion(goal.id)
    redirect_to editobjective_path(objective_id: goal.objective_id)
  end

  private

  def update_goal_completion(goal_id)
    all_goals = Activity.where(goal_id: goal_id).count
    checked_goals = Activity.where(goal_id: goal_id).where(checked: true).count
    Goal.find(goal_id).update_attribute(:progress,
                                        checked_goals.zero? || all_goals.zero? ? 0 : ((checked_goals.to_f / all_goals.to_f) * 100))
  end

  def update_sphere_completion(goal_id)
    # TODO improve method
    goal = Goal.find(goal_id)
    objective = current_plan.objectives.find(goal.objective_id)
    sphere = Sphere.find(objective.sphere_id)
    total_progress = 0
    total_goals = 0
    sphere.objectives.where(plan_id: current_plan.id).each do |objective|
      objective.goals.each do |goal|
        total_goals += goal.activities.count
        total_progress += Activity.where(goal_id: goal.id).where(checked: true).count
      end
    end
    sphere.update_attribute(:progress,
                            total_progress.is_a?(Float) || total_goals.zero? ? 0 : ((total_progress.to_f / total_goals.to_f) * 100).round(2))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:activity).permit(:title, :checked, :goal_id)
  end
end
