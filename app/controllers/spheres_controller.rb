class SpheresController < ApplicationController
  load_and_authorize_resource
  before_action :set_sphere, only: [:edit, :update, :destroy]

  # GET /spheres
  # GET /spheres.json
  def index
    @spheres = current_user.spheres
  end

  # GET /spheres/new
  def new
    @sphere = Sphere.new
  end

  # GET /spheres/1/edit
  def edit
  end

  # POST /spheres
  # POST /spheres.json
  def create
    @sphere = Sphere.new(sphere_params)
    @sphere.user_id = current_user.id
    @sphere.progress = 0
    respond_to do |format|
      if @sphere.save
        format.html {redirect_to new_sphere_path, notice: "Âmbito foi criado com sucesso"}
      else
        format.html {render :new}
        format.json {render json: @sphere.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /spheres/1
  # PATCH/PUT /spheres/1.json
  def update
    respond_to do |format|
      if @sphere.update(sphere_params)
        format.html {redirect_to myplan_path, notice: "Âmbito foi atualizado com sucesso"}
      else
        format.html {render :edit}
        format.json {render json: @sphere.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /spheres/1
  # DELETE /spheres/1.json
  def destroy
    @sphere.destroy
    respond_to do |format|
      format.html {redirect_to myplan_path, notice: "Âmbito foi excluído com sucesso"}
      format.json {head :no_content}
    end
  end

  def sphereobjectives
    if Sphere.find(params[:sphere_id]).user_id == current_user.id
      @objectives = current_plan.objectives.where(sphere_id: params[:sphere_id]).where(plan_id: current_plan.id)
    else
      raise CanCan::AccessDenied.new('Você não pode acessar esse âmbito')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sphere
    @sphere = Sphere.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sphere_params
    params.require(:sphere).permit(:name, :user_id, :progress)
  end

end
