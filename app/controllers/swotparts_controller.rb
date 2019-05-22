class SwotpartsController < ApplicationController
  before_action :set_swotpart, only: [:show, :edit, :update, :destroy]

  # GET /swotparts
  # GET /swotparts.json
  def index
    @swotparts = current_plan.swotparts
  end

  # GET /swotparts/1
  # GET /swotparts/1.json
  def show
  end

  # GET /swotparts/new
  def new
    @swotpart = Swotpart.new
  end

  # GET /swotparts/1/edit
  def edit
    @plan_id = current_plan.id
  end

  # POST /swotparts
  # POST /swotparts.json
  def create
    @swotpart = Swotpart.new(plan_id: current_plan.id, name: params[:name], partname: params[:partname])

    if @swotpart.save
      flash[:notice] = "Força adicionada"
    else
      flash[:info] = "Força não pode ser adicionada"
    end

    redirect_to plans_swotedit_path
  end


  # PATCH/PUT /swotparts/1
  # PATCH/PUT /swotparts/1.json
  def update
    respond_to do |format|
      if @swotpart.update(swotpart_params)
        format.html {redirect_to plans_swotedit_path, notice: "Característica da SWOT atualizada com sucesso"}
        format.json {render :show, status: :ok, location: @swotpart}
      else
        @plan_id = current_plan.id
        format.html {render :edit}
        format.json {render json: @swotpart.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /swotparts/1
  # DELETE /swotparts/1.json
  def destroy
    @swotpart.destroy
    respond_to do |format|
      format.html {redirect_to plans_swotedit_path, notice: "Força removida"}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_swotpart
    @swotpart = Swotpart.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def swotpart_params
    params.require(:swotpart).permit(:plan_id, :name, :partname)
  end
end
