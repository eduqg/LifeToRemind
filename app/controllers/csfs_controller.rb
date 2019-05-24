class CsfsController < ApplicationController
  before_action :set_csf, only: [:show, :edit, :update, :destroy]

  # GET /csfs
  # GET /csfs.json
  def index
    @csfs = current_user.csfs
  end

  # GET /csfs/1
  # GET /csfs/1.json
  def show
  end

  # GET /csfs/new
  def new
    @csf = Csf.new
  end

  # GET /csfs/1/edit
  def edit
  end

  # POST /csfs
  # POST /csfs.json
  def create
    @csf = Csf.new(csf_params)
    @csf.user_id = current_user.id

    respond_to do |format|
      if @csf.save
        format.html { redirect_to csfs_path, notice: 'Csf was successfully created.' }
        format.json { render :show, status: :created, location: @csf }
      else
        format.html { render :new }
        format.json { render json: @csf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csfs/1
  # PATCH/PUT /csfs/1.json
  def update
    respond_to do |format|
      if @csf.update(csf_params)
        format.html { redirect_to csfs_path, notice: 'Csf was successfully updated.' }
        format.json { render :show, status: :ok, location: @csf }
      else
        format.html { render :edit }
        format.json { render json: @csf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csfs/1
  # DELETE /csfs/1.json
  def destroy
    if @csf.id == current_plan.selected_csf
      # Unset selected vision
      current_plan.update_attribute(:selected_csf, nil)
    end
    @csf.destroy
    flash[:info] = "Visão foi excluída"
    redirect_to csfs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csf
      @csf = Csf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def csf_params
      params.require(:csf).permit(:what_makes_me_unique, :best_attributes, :essential_atributes, :health_factors, :user_id)
    end
end
