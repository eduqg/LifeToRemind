class Csf < ApplicationRecord
  belongs_to :user
  validates_presence_of :best_attributes, :essential_atributes, :what_makes_me_unique, :health_factors
  validates :user, uniqueness: { scope: [:best_attributes, :essential_atributes, :what_makes_me_unique, :health_factors], message: "Você já possui esse fator crítico de sucesso" }
end
