module HashImporters
  class GoalHashImporter < Base
    MODEL = Goal

    ATTS = [:name, :progress, :objective_id].freeze

    MESSAGES = {
      success: 'Meta criada',
      failure: 'Meta não criada',
    }.freeze

    def self.import(hash)
      goal = super(hash)
      import_children(hash, goal.id) unless goal.nil?
    end

    def self.import_children(hash, goal_id)
      import_each(
        hash, :activities, ActivityHashImporter, goal_id: goal_id
      )
    end
  end
end
