require 'json'
require 'uri'

class PlansController < ApplicationController
  load_and_authorize_resource
  before_action :set_plan, only: [:edit, :update, :destroy]


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

  def import_page
  end

  def import
    begin
      import_plan(params[:file])
    rescue StandardError => bang
      flash[:info] = "Erro na importação de planos: #{bang}"
      redirect_to plans_import_page_path
    end
  end

  def export
    if current_plan
      @user = current_user
      @spheres = current_user.spheres
      @plans = current_user.plans
      @objectives = current_plan.objectives
      @missions = current_user.missions
      @visions = current_user.visions
      @csfs = current_user.csfs
      @swotparts = current_plan.swotparts
      @values = current_plan.values
      @roles = current_plan.roles

      respond_to do |format|
        format.json do
          data = render_to_string(template: "plans/export.json.jbuilder", formats: 'json')
          send_data data, type: 'application/json; header=present', disposition: "attachment; filename=#{current_user.email}_plans.json"
        end
      end
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
                 grayscale: true,
                 zoom: 1,
                 dpi: 75,
                 margin: {top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10},
                 disable_links: true,
                 disable_toc_links: true,
                 disable_back_links: true,
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

  def create_sphere(hash_sphere)
    new_sphere = Sphere.new
    new_sphere.user_id = current_user.id
    new_sphere.name = hash_sphere[:name]
    new_sphere.progress = hash_sphere[:progress]
    # Spheres validates name duplications
    new_sphere.save ? new_sphere : current_user.spheres.where(name: "#{hash_sphere[:name]}").first
  end

  def create_plan(hash_plan, user_id)
    new_plan = Plan.new
    new_plan.user_id = user_id
    new_plan.name = hash_plan[:name]
    new_plan.selected_mission = hash_plan[:selected_mission]
    new_plan.selected_vision = hash_plan[:selected_vision]
    new_plan.selected_csf = hash_plan[:selected_csf]
    new_plan.save ? new_plan.id : nil
  end

  def create_swotpart(hash_swotpart, plan_id)
    new_swotpart = Swotpart.new
    new_swotpart.plan_id = plan_id
    new_swotpart.name = hash_swotpart[:name]
    new_swotpart.partname = hash_swotpart[:partname]
    new_swotpart.save
  end

  def create_value(hash_value, plan_id)
    new_value = Value.new
    new_value.plan_id = plan_id
    new_value.name = hash_value[:name]
    new_value.save
  end

  def create_role(hash_role, plan_id)
    new_role = Role.new
    new_role.plan_id = plan_id
    new_role.name = hash_role[:name]
    new_role.description = hash_role[:description]
    new_role.name = hash_role[:name]
    new_role.save
  end

  def create_objective(hash_objective, plan_id, sphere_id)
    new_objective = Objective.new
    new_objective.plan_id = plan_id
    new_objective.sphere_id = sphere_id
    new_objective.name = hash_objective[:name]
    new_objective.concluded = hash_objective[:concluded]
    new_objective.save ? new_objective.id : nil
  end

  def create_goal(hash_goal, objective_id)
    new_goal = Goal.new
    new_goal.objective_id = objective_id
    new_goal.name = hash_goal[:name]
    new_goal.progress = hash_goal[:progress]
    new_goal.save ? new_goal.id : nil
  end

  def create_activity(hash_activity, goal_id)
    new_activity = Activity.new
    new_activity.goal_id = goal_id
    new_activity.title = hash_activity[:title]
    new_activity.checked = hash_activity[:checked]
    new_activity.save
  end

  def create_mission(hash_mission, user_id)
    new_mission = Mission.new
    new_mission.user_id = user_id
    new_mission.purpose_of_life = hash_mission[:purpose_of_life]
    new_mission.who_am_i = hash_mission[:who_am_i]
    new_mission.why_exist = hash_mission[:why_exist]
    new_mission.save
  end

  def create_vision(hash_vision, user_id)
    new_vision = Vision.new
    new_vision.user_id = user_id
    new_vision.where_im_going = hash_vision[:where_im_going]
    new_vision.where_arrive = hash_vision[:where_arrive]
    new_vision.how_complete_mission = hash_vision[:how_complete_mission]
    new_vision.save
  end

  def create_csf(hash_csf, user_id)
    new_csf = Csf.new
    new_csf.user_id = user_id
    new_csf.what_makes_me_unique = hash_csf[:what_makes_me_unique]
    new_csf.best_attributes = hash_csf[:best_attributes]
    new_csf.essential_atributes = hash_csf[:essential_atributes]
    new_csf.health_factors = hash_csf[:health_factors]
    new_csf.save
  end

  def import_plan(file)
    puts "---- Inicio da importação------"
    puts file.path
    puts file.size
    puts file.content_type

    # 20000 bytes = 20 kilobyte = 0.02 Megabytes
    if file.size > 20000
      raise StandardError.new('Erro de tamanho de arquivo')
    end

    file_string = file.path.to_s

    if (file_string[-5, 5]).eql? '.json'
      IO.foreach(Rails.root.join(file.path)) do |plan_json_line|
        begin
          plans_hash = JSON.parse(plan_json_line)
          create_all_plans(plans_hash)
        rescue JSON::ParserError, TypeError => e
          raise StandardError.new('Arquivo importado não é um JSON válido.')
        end
      end
      redirect_to plans_import_page_path, notice: "Planos importados"
    else
      raise StandardError.new('Formato de arquivo inválido')
    end

  end

  def create_all_plans(plans_hash)
    user = {
        id: plans_hash.fetch('id'),
        email: plans_hash.fetch('email'),
        name: plans_hash.fetch('name'),
        selected_plan: plans_hash.fetch('selected_plan'),
        created_at: plans_hash.fetch('created_at')}

    if plans_hash.has_key?("spheres")
      new_spheres_hash = {}
      plans_hash["spheres"].each do |sphere|
        hash_sphere = {
            id: sphere.fetch('id'),
            user_id: sphere.fetch('user_id'),
            name: sphere.fetch('name'),
            progress: sphere.fetch('progress'),
        }
        if (new_sphere = create_sphere(hash_sphere))
          new_spheres_hash["#{new_sphere.name}"] = new_sphere.id
          puts "Âmbito criado"
        else
          puts "Âmbito não criado"
        end
      end
    end

    if plans_hash.has_key?("missions")
      plans_hash["missions"].each do |mission|
        puts "----- MISSION -------"
        hash_mission = {
            id: mission.fetch('id'),
            user_id: mission.fetch('user_id'),
            purpose_of_life: mission.fetch('purpose_of_life'),
            who_am_i: mission.fetch('who_am_i'),
            why_exist: mission.fetch('why_exist'),
        }

        create_mission(hash_mission, current_user.id) ? (puts "Missão criada") : (puts "Missão não criada")
      end
    end

    if plans_hash.has_key?("visions")
      plans_hash["visions"].each do |vision|
        puts "----- VISION -------"
        hash_vision = {
            id: vision.fetch('id'),
            user_id: vision.fetch('user_id'),
            where_im_going: vision.fetch('where_im_going'),
            where_arrive: vision.fetch('where_arrive'),
            how_complete_mission: vision.fetch('how_complete_mission'),
        }

        create_vision(hash_vision, current_user.id) ? (puts "Visão criada") : (puts "Visão não criado")
      end
    end

    if plans_hash.has_key?("csfs")
      plans_hash["csfs"].each do |csf|
        hash_csf = {
            id: csf.fetch('id'),
            user_id: csf.fetch('user_id'),
            what_makes_me_unique: csf.fetch('what_makes_me_unique'),
            best_attributes: csf.fetch('best_attributes'),
            essential_atributes: csf.fetch('essential_atributes'),
            health_factors: csf.fetch('health_factors'),
        }

        create_csf(hash_csf, current_user.id) ? (puts "Fator Crítido de Sucesso criado") : (puts "Fator Crítido de Sucesso não criado")
      end
    end

    if plans_hash.has_key?("plans")
      plans_hash["plans"].each do |plan|
        hash_plan = {
            id: plan.fetch('id'),
            user_id: plan.fetch('user_id'),
            name: plan.fetch('name'),
            selected_mission: plan.fetch('selected_mission'),
            selected_vision: plan.fetch('selected_vision'),
            selected_csf: plan.fetch('selected_csf'),
        }

        if (new_plan_id = create_plan(hash_plan, current_user.id))
          puts "Plano criado"
        else
          puts "Plano não criado"
        end


        if plan.has_key?("swotparts")
          plan["swotparts"].each do |swotpart|
            hash_swotpart = {
                id: swotpart.fetch('id'),
                plan_id: swotpart.fetch('plan_id'),
                name: swotpart.fetch('name'),
                partname: swotpart.fetch('partname'),
            }

            create_swotpart(hash_swotpart, new_plan_id) ? (puts "Swotpart criada") : (puts "Valor não criado")
          end
        end

        if plan.has_key?("values")
          plan["values"].each do |value|
            hash_value = {
                id: value.fetch('id'),
                plan_id: value.fetch('plan_id'),
                name: value.fetch('name'),
            }

            create_value(hash_value, new_plan_id) ? (puts "Valor criado") : (puts "Valor não criado")
          end
        end

        if plan.has_key?("roles")
          plan["roles"].each do |role|
            hash_role = {
                id: role.fetch('id'),
                plan_id: role.fetch('plan_id'),
                name: role.fetch('name'),
                description: role.fetch('description')
            }

            create_role(hash_role, new_plan_id) ? (puts "Papel criado") : (puts "Papel não criado")
          end
        end

        if plan.has_key?("objectives")
          plan["objectives"].each do |objective|
            puts new_spheres_hash

            hash_objective = {
                id: objective.fetch('id'),
                plan_id: objective.fetch('plan_id'),
                sphere_name: objective.fetch('sphere_name'),
                name: objective.fetch('name'),
                concluded: objective.fetch('concluded'),
            }

            if (new_objective_id = create_objective(hash_objective, new_plan_id, new_spheres_hash["#{hash_objective[:sphere_name]}"]))
              puts "Objetivo criado"
            else
              puts "Objetivo não criado"
            end

            if objective.has_key?("goals")
              objective["goals"].each do |goal|
                hash_goal = {
                    id: goal.fetch('id'),
                    objective_id: goal.fetch('objective_id'),
                    name: goal.fetch('name'),
                    progress: goal.fetch('progress')
                }

                if (new_goal_id = create_goal(hash_goal, new_objective_id))
                  puts "Meta criada"
                else
                  puts "Meta não criada"
                end

                if goal.has_key?("activities")
                  goal["activities"].each do |activity|
                    hash_activity = {
                        id: activity.fetch('id'),
                        goal_id: activity.fetch('goal_id'),
                        title: activity.fetch('title'),
                        checked: activity.fetch('checked')
                    }

                    if create_activity(hash_activity, new_goal_id)
                      puts "Atividade criada"
                    else
                      puts "Atividade não criada"
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    puts "---- Fim da importação ------"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plan_params
    params.require(:plan).permit(:name, :selected_mission, :selected_vision, :selected_csf, :user_id)
  end
end
