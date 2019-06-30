class CsfsController < ApplicationController
  load_and_authorize_resource
  before_action :set_csf, only: [:edit, :update, :destroy]

  # GET /csfs
  # GET /csfs.json
  def index
    @csfs = current_user.csfs
  end

  # GET /csfs/new
  def new
    @my_csf = Csf.find(current_plan.selected_csf) rescue nil
    @csf = Csf.new
  end

  # GET /csfs/1/edit
  def edit
    csf = Csf.find(params[:id])

    if current_user.id == csf.user_id
      @csf = csf
    else
      raise CanCan::AccessDenied.new('Você não pode editar esse fator crítico de sucesso')
    end
  end

  # POST /csfs
  # POST /csfs.json
  def create
    @csf = Csf.new(csf_params)
    @csf.user_id = current_user.id

    respond_to do |format|
      if @csf.save
        current_plan.update_attribute(:selected_csf, @csf.id)
        format.html {redirect_to new_csf_path, notice: "O Fator Crítico de Sucesso criado foi adicionada ao seu planejamento"}
      else
        format.html {render :new}
        format.json {render json: @csf.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /csfs/1
  # PATCH/PUT /csfs/1.json
  def update
    if current_user.id == @csf.user_id
      respond_to do |format|
        if @csf.update(csf_params)
          format.html {redirect_to csfs_path, notice: "Fator crítico de sucesso atualizado"}
        else
          format.html {render :edit}
          format.json {render json: @csf.errors, status: :unprocessable_entity}
        end
      end
    else
      raise CanCan::AccessDenied.new('Você não pode atualizar esse fator crítico de sucesso')
    end
  end

  def update_selected_csf
    if plan_to_update = current_plan
      plan_to_update.update_attribute(:selected_csf, params[:csf_id])
      flash[:notice] = "Fator crítico de sucesso selecionado foi atualizada com sucesso"
      redirect_to myplan_path
    else
      flash[:info] = "Fator crítico de sucesso selecionado não pode ser atualizado"
    end
  end

  # DELETE /csfs/1
  # DELETE /csfs/1.json
  def destroy
    if @csf.id == current_plan.selected_csf
      # Unset selected critical success factor
      current_plan.update_attribute(:selected_csf, nil)
    end
    if current_user.id == @csf.user_id
      @csf.destroy
      flash[:info] = "Fator crítico de sucesso foi excluído"
      redirect_to csfs_path
    else
      raise CanCan::AccessDenied.new('Você não pode excluir esse fator crítico de sucesso')
    end
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
