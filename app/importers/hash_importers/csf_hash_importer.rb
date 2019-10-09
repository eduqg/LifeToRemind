module HashImporters
  class CsfHashImporter < Base
    MODEL = Csf

    ATTS = [:what_makes_me_unique, :best_attributes, :essential_atributes,
            :health_factors, :user_id].freeze

    MESSAGES = {
      success: 'Fator Crítido de Sucesso criado'.freeze,
      failure: 'Fator Crítido de Sucesso não criado'.freeze
    }.freeze
  end
end
