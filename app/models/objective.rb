class Objective < ApplicationRecord
  belongs_to :plan
  belongs_to :sphere
  validates :name, presence: true
end
