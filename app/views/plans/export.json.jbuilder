json.call(
    @user,
    :id,
    :email,
    :name,
    :selected_plan,
    :created_at,
)

if (@spheres.first.user_id == @user.id if @spheres.first.present?)
  json.spheres do
    json.array! @spheres do |sphere|
      json.id sphere.id
      json.user_id sphere.user_id
      json.name sphere.name
      json.progress sphere.progress
    end
  end
end

json.missions do
  json.array! @missions do |mission|
    json.id mission.id
    json.user_id mission.user_id
    json.purpose_of_life mission.purpose_of_life
    json.who_am_i mission.who_am_i
    json.why_exist mission.why_exist
  end
end

json.visions do
  json.array! @visions do |vision|
    json.id vision.id
    json.user_id vision.user_id
    json.where_im_going vision.where_im_going
    json.where_arrive vision.where_arrive
    json.how_complete_mission vision.how_complete_mission
  end
end

json.csfs do
  json.array! @csfs do |csf|
    json.id csf.id
    json.user_id csf.user_id
    json.what_makes_me_unique csf.what_makes_me_unique
    json.best_attributes csf.best_attributes
    json.essential_atributes csf.essential_atributes
    json.health_factors csf.health_factors
  end
end

json.plans do
  json.array! @plans do |plan|
    json.id plan.id
    json.user_id plan.user_id
    json.name plan.name
    json.selected_mission plan.selected_mission
    json.selected_vision plan.selected_vision
    json.selected_csf plan.selected_csf

    if (@swotparts.first.plan_id == plan.id if @swotparts.first.present?)
      json.swotparts do
        json.array! @swotparts do |swotpart|
          json.id swotpart.id
          json.plan_id swotpart.plan_id
          json.name swotpart.name
          json.partname swotpart.partname
        end
      end
    end

    if (@values.first.plan_id == plan.id if @values.first.present?)
      json.values do
        json.array! @values do |value|
          json.id value.id
          json.plan_id value.plan_id
          json.name value.name
        end
      end
    end

    if (@roles.first.plan_id == plan.id if @roles.first.present?)
      json.roles do
        json.array! @roles do |role|
          json.id role.id
          json.plan_id role.plan_id
          json.name role.name
          json.description role.description
        end
      end
    end

    if (@objectives.first.plan_id == plan.id if @objectives.first.present?)
      json.objectives do
        json.array! @objectives do |objective|
          json.id objective.id
          json.plan_id objective.plan_id
          json.sphere_name Sphere.find(objective.sphere_id).name
          json.name objective.name
          json.concluded objective.concluded

          if (objective.goals.first.objective_id == objective.id if objective.goals.first.present?)
            json.goals do
              json.array! objective.goals do |goal|
                json.id goal.id
                json.objective_id goal.objective_id
                json.name goal.name
                json.progress goal.progress

                if (goal.activities.first.goal_id == goal.id if goal.activities.first.present?)
                  json.activities do
                    json.array! goal.activities do |activity|
                      json.id activity.id
                      json.goal_id activity.goal_id
                      json.title activity.title
                      json.checked activity.checked
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
