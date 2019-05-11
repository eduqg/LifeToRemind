class Goal < ApplicationRecord
  belongs_to :objective
  validates :name, presence: true
end
