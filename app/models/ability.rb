class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    can [:create, :new], Contact

    if user.present? # additional permissions for logged in users (they can read their own posts)
      if user.admin? # additional permissions for administrators
        can :manage, :all
      else
        can :crud, User, user_id: user.id
        can :current_plan, ApplicationController
        can [:index, :show, :create, :new, :update, :edit, :destroy, :update_selected_plan, :pdf, :swotedit, :destroy, :myplan, :inicio], Plan
        can [:create, :new, :update, :edit, :destroy], Swotpart
        can [:index, :show, :create, :new, :update, :edit, :destroy, :update_selected_mission], Mission
        can [:index, :show, :create, :new, :update, :edit, :destroy, :update_selected_vision], Vision
        can [:index, :show, :create, :new, :update, :edit, :destroy], Value
        can [:create, :new], Role
        can [:index, :show, :edit, :update, :destroy], Role do |role|
          plan = Plan.find(role.plan_id)
          plan.user_id == user.id
        end
        can [:index, :show, :create, :new, :update, :edit, :destroy, :update_selected_csf], Csf
        can [:index, :show, :create, :new, :update, :edit, :destroy, :sphereobjectives], Sphere

        can [:create, :new], Objective
        can [:update, :edit, :destroy, :editobjective], Objective do |objective|
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Goal
        can [:update, :edit, :destroy], Goal do |goal|
          objective = Objective.find(goal.objective_id)
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Activity
        can [:destroy, :checked], Activity do |act|
          goal = Goal.find(act.goal_id)
          objective = Objective.find(goal.objective_id)
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end
      end
    end
  end
end
