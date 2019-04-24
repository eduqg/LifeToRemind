class MissionsController < ApplicationController
  before_action :set_mission, only: [:edit, :update, :destroy]
  def index
    @missions = Mission.all
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
      redirect_to root_url
    else
      render :edit
    end
  end

  def create
    @mission = Mission.new mission_params
    @mission.plan_id = "1"

    if @mission.save
      flash[:notice] = "Missão criada com sucesso"
      redirect_to root_url
    else
      render :new
    end 
  end

  def destroy
    @mission.destroy
    redirect_to root_url
  end

  private

  def mission_params
    mission = params.require(:mission).permit(:purpose_of_life, :who_am_i, :why_exist, :plan_id)
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end
end
