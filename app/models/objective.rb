class Objective < ApplicationRecord
  belongs_to :plan
  belongs_to :sphere
  has_many :goals, dependent: :destroy
  validates :name, presence: true
end
