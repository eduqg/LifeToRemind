class Plan < ApplicationRecord
  belongs_to :user
  has_many :missions, dependent: :destroy
  has_many :swotparts, dependent: :destroy
  has_many :objectives, dependent: :destroy

  validates :name, presence: true
  validates :name, length: {minimum: 4, maximum: 30}
end
