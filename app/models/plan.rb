class Plan < ApplicationRecord
  belongs_to :user
  has_many :missions, dependent: :destroy
  has_many :swotparts, dependent: :destroy
  has_many :objectives, dependent: :destroy

  validates :life_objective, presence: true
  validates :life_objective, length: {minimum: 4, maximum: 30}
end
