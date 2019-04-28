class Plan < ApplicationRecord
  belongs_to :user
  has_many :missions
  validates :life_objective, presence: true
end
