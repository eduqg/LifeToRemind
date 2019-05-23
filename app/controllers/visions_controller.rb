class VisionsController < ApplicationController
  before_action :set_vision, only: [:edit, :update, :destroy]

  # GET /visions
  # GET /visions.json
  def index
    @visions = current_user.visions
  end

  # GET /visions/new
  def new
    @vision = Vision.new
  end

  # GET /visions/1/edit
  def edit
  end

  # POST /visions
  # POST /visions.json
  def create
    @vision = Vision.new(vision_params)
    @vision.user_id = current_user.id

    respond_to do |format|
      if @vision.save
        format.html {redirect_to visions_path, notice: "Visão criada com sucesso"}
      else
        format.html {render :new}
        format.json {render json: @vision.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /visions/1
  # PATCH/PUT /visions/1.json
  def update
    respond_to do |format|
      if @vision.update(vision_params)
        format.html {redirect_to visions_path, notice: "Visão atualizada com sucesso!"}
      else
        format.html {render :edit}
        format.json {render json: @vision.errors, status: :unprocessable_entity}
      end
    end
  end

  def update_selected_vision
    if (plan_to_update = current_plan)
      plan_to_update.update_attribute(:selected_vision, params[:vision_id])
      flash[:notice] = "Visão selecionada foi atualizada com sucesso"
      redirect_back(fallback_location: visions_path)
    else
      flash[:info] = "Visão selecionada não pode ser atualizada"
    end
  end

  # DELETE /visions/1
  # DELETE /visions/1.json
  def destroy
    if @vision.id == current_plan.selected_vision
      # Unset selected vision
      current_plan.update_attribute(:selected_vision, nil)
    end
    @vision.destroy
    flash[:info] = "Visão foi excluída"
    redirect_to visions_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vision
    @vision = Vision.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vision_params
    vision = params.require(:vision).permit(:where_im_going, :where_arrive, :how_complete_mission, :user_id)
  end

end
