class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = current_user.plans
  end

  def myplan
    if current_plan
      @my_mission = Mission.find(current_plan.selected_mission) rescue nil
      @my_vision = Vision.find(current_plan.selected_vision) rescue nil
      @my_csf = Csf.find(current_plan.selected_csf) rescue nil
      @strengths = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :strength)
      @weaks = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :weak)
      @opportunities = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :opportunity)
      @threats = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :threat)
      @objectives = current_plan.objectives
      @spheres = current_user.spheres
      @value = Value.new
      @role = Role.new
    else
      redirect_to plans_path
    end
  end

  def pdf
    if current_plan
      @my_mission = Mission.find(current_plan.selected_mission) rescue nil
      @my_vision = Vision.find(current_plan.selected_vision) rescue nil
      @my_csf = Csf.find(current_plan.selected_csf) rescue nil
      @strengths = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :strength)
      @weaks = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :weak)
      @opportunities = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :opportunity)
      @threats = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :threat)
      @objectives = current_plan.objectives
      @spheres = current_user.spheres
      @value = Value.new
      @role = Role.new

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Planejamento de #{current_user.name}",
                 page_size: "A4",
                 template: "plans/pdf.html.erb",
                 orientation: "Portrait",
                 title: "Planejamento de #{current_user.name}",
                 plans: "pdf.html.erb",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75,
                 margin:  {   top:               20,
                              bottom:            20,
                              left:              20,
                              right:             20 },
                 disable_links:     true,
                 disable_toc_links: true,
                 disable_back_links:true,
                 javascript_delay: 3000
        end
      end
    else
      redirect_to plans_path
    end
  end

  def swotedit
    if current_plan
      @strengths = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :strength)
      @weaks = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :weak)
      @opportunities = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :opportunity)
      @threats = current_plan.swotparts.where(plan_id: current_plan.id).where(partname: :threat)
    else
      redirect_to plans_path
    end
  end

  def inicio
    if current_plan
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
    else
      redirect_to plans_path
    end

  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = current_plan

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice No. #{@plan.id}",
               page_size: 'A4',
               template: "plans/show.html.erb",
               layout: "pdf.html",
               orientation: "Landscape",
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
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
        current_user.update_attribute(:selected_plan, @plan.id)
        format.html {redirect_to plans_swotedit_path, notice: "Plano criado com sucesso"}
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
    current_user.update_attribute(:selected_plan, params[:plan_id])
    flash[:notice] = "Plano selecionada foi atualizada com sucesso"
    redirect_to myplan_path
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    current_user.selected_plan = nil
    current_user.save
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
    params.require(:plan).permit(:name, :selected_mission, :selected_vision, :selected_csf, :user_id)
  end
end
