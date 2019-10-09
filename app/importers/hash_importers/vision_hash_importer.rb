module HashImporters
  class VisionHashImporter < Base
    MODEL = Vision

    ATTS = [:where_im_going, :where_arrive, :how_complete_mission,
            :user_id].freeze

    MESSAGES = {
      success: 'Visão criada'.freeze,
      failure: 'Visão não criado'.freeze,
      header: 'VISION'
    }.freeze
  end
end
