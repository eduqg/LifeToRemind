class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = current_user.plans
  end

  def myplan
    if current_plan
      @current_plan = Plan.find(current_user.selected_plan)
      if current_plan.selected_mission
        @my_mission = Mission.find(current_plan.selected_mission)
      end
      @strengths = Swotpart.where(plan_id: current_plan.id).where(partname: :strength)
      @weaks = Swotpart.where(plan_id: current_plan.id).where(partname: :weak)
      @opportunities = Swotpart.where(plan_id: current_plan.id).where(partname: :opportunity)
      @threats = Swotpart.where(plan_id: current_plan.id).where(partname: :threat)

      @objectives = current_plan.objectives
    else
      redirect_to plans_path
    end

  end

  def swotedit
    @strengths = Swotpart.where(plan_id: current_plan.id).where(partname: :strength)
    @weaks = Swotpart.where(plan_id: current_plan.id).where(partname: :weak)
    @opportunities = Swotpart.where(plan_id: current_plan.id).where(partname: :opportunity)
    @threats = Swotpart.where(plan_id: current_plan.id).where(partname: :threat)
  end

  def inicio
    @strengths = Swotpart.where(plan_id: current_plan.id).where(partname: :strength)
    @weaks = Swotpart.where(plan_id: current_plan.id).where(partname: :weak)
    @opportunities = Swotpart.where(plan_id: current_plan.id).where(partname: :opportunity)
    @threats = Swotpart.where(plan_id: current_plan.id).where(partname: :threat)

    @objectives = current_plan.objectives
    @spheres = current_user.spheres


    @chartColors = [
        ['rgba(255, 0, 0, 0.71)'],
        ['rgba(255, 255, 0, 0.71)'],
        ['rgba(0, 168, 0, 0.71)']
    ]

  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id

    respond_to do |format|
      if @plan.save
        format.html {redirect_to plans_path, notice: "Plano criado com sucesso"}
        format.json {render :show, status: :created, location: @plan}
      else
        format.html {render :new}
        format.json {render json: @plan.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html {redirect_to plans_path, notice: "Plano atualizado com sucesso"}
        format.json {render :show, status: :ok, location: @plan}
      else
        format.html {render :edit}
        format.json {render json: @plan.errors, status: :unprocessable_entity}
      end
    end
  end

  def update_selected_plan
    if (user_to_update = current_user)
      user_to_update.update_attribute(:selected_plan, params[:format])
      flash[:notice] = "Plano selecionada foi atualizada com sucesso"
      redirect_to myplan_path
    else
      flash[:notice] = "Plano selecionada não pode ser atualizado"
      redirect_back(fallback_location: plans_path)
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      flash[:info] = "Plano foi excluído"
      format.html {redirect_to plans_url}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plan_params
    params.require(:plan).permit(:name, :selected_mission, :selected_vision, :critical_success_factors_selected, :user_id)
  end
end
