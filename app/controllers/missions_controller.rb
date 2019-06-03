class MissionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_mission, only: [:edit, :update, :destroy]

  def index
    @missions = current_user.missions
  end

  def new
    @mission = Mission.new
  end

  def edit
    render :edit
  end

  def update
    if @mission.update mission_params
      flash[:notice] = "Missão atualizada com sucesso!"
      redirect_to missions_url
    else
      render :edit
    end
  end

  def update_selected_mission
    if (plan_to_update = current_plan)
      plan_to_update.update_attribute(:selected_mission, params[:mission_id])
      flash[:notice] = "Missão selecionada foi atualizada com sucesso"
      redirect_to myplan_path
    else
      flash[:info] = "Missão selecionada não pode ser atualizada"
    end
  end

  def create
    @mission = Mission.new mission_params
    @mission.user_id = current_user.id

    if @mission.save
      current_plan.update_attribute(:selected_mission, @mission.id)
      flash[:notice] = "A Missão criada foi adicionada ao seu planejamento"
      redirect_to new_vision_path
    else
      render :new
    end
  end

  def destroy
    if @mission.id == current_plan.selected_mission
      # Unset selected mission
      current_plan.update_attribute(:selected_mission, nil)
    end

    @mission.destroy
    flash[:info] = "Missão foi excluída"
    redirect_to missions_url
  end

  private

  def mission_params
    mission = params.require(:mission).permit(:purpose_of_life, :who_am_i, :why_exist, :user_id)
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end

end
