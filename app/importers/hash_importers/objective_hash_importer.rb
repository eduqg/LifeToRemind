module HashImporters
  class ObjectiveHashImporter < Base
    MODEL = Objective

    ATTS = [:name, :concluded, :plan_id, :sphere_id].freeze

    MESSAGES = {
      success: 'Objetivo criado'.freeze,
      failure: 'Objetivo não criado'.freeze
    }.freeze

    def self.import(hash)
      objective = super(hash)
      import_children(hash, objective.id) unless objective.nil?
    end

    def self.import_children(hash, objective_id)
      import_each(hash, :goals, GoalHashImporter, objective_id: objective_id)
    end
  end
end
