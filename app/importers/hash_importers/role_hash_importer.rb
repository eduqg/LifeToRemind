module HashImporters
  class RoleHashImporter < Base
    MODEL = Role

    ATTS = [:name, :description, :plan_id].freeze

    MESSAGES = {
      success: 'Papel criado'.freeze,
      failure: 'Papel não criado'.freeze,
    }.freeze
  end
end
