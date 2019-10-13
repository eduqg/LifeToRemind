module HashImporters
  class SwotpartHashImporter < Base
    MODEL = Swotpart

    ATTS = [:name, :partname, :plan_id].freeze

    MESSAGES = {
      success: 'Swotpart criada'.freeze,
      failure: 'Swotpart não criado'.freeze
    }.freeze
  end
end
