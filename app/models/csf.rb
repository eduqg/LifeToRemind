class Csf < ApplicationRecord
  belongs_to :user
  validates_presence_of :best_attributes, :essential_atributes, :what_makes_me_unique, :health_factors
end
