class Sphere < ApplicationRecord
  belongs_to :user
  has_many :objectives, dependent: :destroy
  validates :name, presence: true
  validates :name, length: {minimum: 4, maximum: 30}
end
