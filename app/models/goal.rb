class Goal < ApplicationRecord
  belongs_to :objective
  has_many :activities
  validates :name, presence: true
end
