class ValuesController < ApplicationController
  load_and_authorize_resource
  before_action :set_value, only: [:edit, :update, :destroy]

  # GET /values
  # GET /values.json
  def index
    @values = current_plan.values
  end

  # GET /values/new
  def new
    @value = Value.new
    @current_plan = current_plan
  end

  # GET /values/1/edit
  def edit
  end

  # POST /values
  # POST /values.json
  def create
    @value = Value.new(value_params)
    @value.plan_id = current_plan.id

    respond_to do |format|
      if @value.save
        format.html {redirect_to new_value_path, notice: "Valor foi criado com sucesso"}
      else
        format.html {render :new}
        format.json {render json: @value.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /values/1
  # PATCH/PUT /values/1.json
  def update
    respond_to do |format|
      if @value.update(value_params)
        format.html {redirect_to myplan_path, notice: "Valor foi atualizado com sucesso"}
      else
        format.html {render :edit}
        format.json {render json: @value.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /values/1
  # DELETE /values/1.json
  def destroy
    @value.destroy
    respond_to do |format|
      format.html {redirect_to values_path, notice: "Valor foi excluído"}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_value
    @value = Value.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def value_params
    params.require(:value).permit(:name, :plan_id)
  end
end
