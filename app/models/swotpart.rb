class Swotpart < ApplicationRecord
  belongs_to :plan
  enum partname: [:strength, :weak, :opportunity, :threat]

  validates :partname, presence: true
end
