module HashImporters
  class MissionHashImporter < Base
    MODEL = Mission

    ATTS = [:purpose_of_life, :who_am_i, :why_exist, :user_id].freeze

    MESSAGES = {
      success: 'Missão criada',
      failure: 'Missão não criada',
      header: 'MISSION'
    }.freeze
  end
end
