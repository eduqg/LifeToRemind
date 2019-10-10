module HashImporters
  class PlanHashImporter < Base
    MODEL = Plan

    ATTS = [:name, :selected_mission, :selected_vision,
            :selected_csf, :user_id].freeze

    MESSAGES = {
      success: 'Plano criado'.freeze,
      failure: 'Plano não criado'.freeze
    }.freeze

    def self.import(hash)
      plan = super(hash)
      import_children(hash, plan.id) unless plan.nil?
    end

    def self.import_children(hash, plan_id)
      import_each(hash, :swotparts, SwotpartHashImporter, plan_id: plan_id)
      import_each(hash, :values, ValueHashImporter, plan_id: plan_id)
      import_each(hash, :roles, RoleHashImporter, plan_id: plan_id)
      import_objectives(hash, plan_id)
    end

    def self.import_objectives(plan_hash, plan_id)
      plan_hash.fetch(:objectives, []).each do |obj|
        sphere_id = plan_hash[:spheres].find do |sphere|
          sphere.name == obj[:sphere_name]
        end&.id
        opts = obj.merge(plan_id: plan_id, sphere_id: sphere_id)
        ObjectiveHashImporter.import(opts)
      end
    end
  end
end
