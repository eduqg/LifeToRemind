class ObjectivesController < ApplicationController
  load_and_authorize_resource
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  # GET /objectives
  # GET /objectives.json
  def index
    if current_plan
      @objectives = current_plan.objectives
    else
      flash[:info] = "É necessário selecionar um plano primeiro"
      redirect_to plans_path
    end
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
  end

  # GET /objectives/new
  def new
    @spheres = current_user.spheres
    @objective = Objective.new
    @current_plan = current_plan
    @objectives = current_plan.objectives
  end

  # GET /objectives/1/edit
  def edit
    @spheres = current_user.spheres
  end

  def editobjective
    @objective = Objective.find(params[:objective_id])
  end

  # POST /objectives
  # POST /objectives.json
  def create
    @objective = Objective.new(objective_params)
    @objective.concluded = false
    @objective.plan_id = current_plan.id

    respond_to do |format|
      if @objective.save
        format.html { redirect_to new_objective_path, notice: "Objetivo foi adicionado ao seu planejamento, adicone Metas e Atividades em Meu Planejamento" }
        format.json { render :show, status: :created, location: @objective }
      else
        # Without @spheres, will render new_objective without spheres on collection_field
        @spheres = current_user.spheres
        format.html { render :new, :collection => @spheres }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_to myplan_path, notice: "Objetivo foi atualizado com sucesso" }
        format.json { render :show, status: :ok, location: @objective }
      else
        format.html { render :edit }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  def editobjectives
    @objectives = current_plan.objectives
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    @objective.destroy
    respond_to do |format|
      format.html { redirect_to myplan_path, notice: "Objetivo Estratégico foi excluído" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
      params.require(:objective).permit(:name, :concluded, :plan_id, :sphere_id)
    end
end
