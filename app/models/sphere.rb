class Sphere < ApplicationRecord
  belongs_to :user
  has_many :objectives, dependent: :destroy
  validates :name, presence: true
end
