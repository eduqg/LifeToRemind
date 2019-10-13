module HashImporters
  class ValueHashImporter < Base
    MODEL = Value

    ATTS = [:name, :plan_id].freeze

    MESSAGES = {
      success: 'Valor criado'.freeze,
      failure: 'Valor não criado'.freeze,
    }.freeze
  end
end
