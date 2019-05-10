class SpheresController < ApplicationController
  before_action :set_sphere, only: [:show, :edit, :update, :destroy]

  # GET /spheres
  # GET /spheres.json
  def index
    @spheres = Sphere.all
  end

  # GET /spheres/1
  # GET /spheres/1.json
  def show
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

    respond_to do |format|
      if @sphere.save
        format.html { redirect_to @sphere, notice: 'Sphere was successfully created.' }
        format.json { render :show, status: :created, location: @sphere }
      else
        format.html { render :new }
        format.json { render json: @sphere.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spheres/1
  # PATCH/PUT /spheres/1.json
  def update
    respond_to do |format|
      if @sphere.update(sphere_params)
        format.html { redirect_to @sphere, notice: 'Sphere was successfully updated.' }
        format.json { render :show, status: :ok, location: @sphere }
      else
        format.html { render :edit }
        format.json { render json: @sphere.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spheres/1
  # DELETE /spheres/1.json
  def destroy
    @sphere.destroy
    respond_to do |format|
      format.html { redirect_to spheres_url, notice: 'Sphere was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sphere
      @sphere = Sphere.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sphere_params
      params.require(:sphere).permit(:name)
    end
end
