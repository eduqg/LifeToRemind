module HashImporters
  class SphereHashImporter < Base
    MODEL = Sphere

    ATTS = [:name, :progress, :user_id].freeze

    MESSAGES = {
      success: 'Âmbito criado',
      failure: 'Âmbito não criado'
    }.freeze
  end
end
