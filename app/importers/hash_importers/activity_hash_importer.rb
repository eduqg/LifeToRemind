module HashImporters
  class ActivityHashImporter < Base
    MODEL = Activity

    ATTS = [:title, :checked, :goal_id].freeze

    MESSAGES = {
      success: 'Atividade criada',
      failure: 'Atividade não criada',
    }.freeze
  end
end
