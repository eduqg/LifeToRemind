class Plan < ApplicationRecord
  belongs_to :user
  validates :life_objective, presence: true
end
