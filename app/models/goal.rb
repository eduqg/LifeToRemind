class Goal < ApplicationRecord
  belongs_to :objective
  has_many :activities, dependent: :destroy
  validates :name, presence: true
end
