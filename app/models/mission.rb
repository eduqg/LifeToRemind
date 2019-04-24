class Mission < ApplicationRecord
  belongs_to :plan

  validates :why_exist, :purpose_of_life, :who_am_i, presence: true
end
