class Mission < ApplicationRecord
  belongs_to :user
  validates :why_exist, :purpose_of_life, :who_am_i, presence: true
  validates :user, uniqueness: { scope: [:why_exist, :purpose_of_life, :who_am_i], message: "Você já possui essa Missão" }
end
