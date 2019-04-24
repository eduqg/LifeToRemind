class Plan < ApplicationRecord
  validates :life_objective, presence: true
end
