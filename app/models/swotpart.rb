class Swotpart < ApplicationRecord
  belongs_to :plan
  enum partname: [:strength, :weak, :opportunity, :threat]

  validates :partname, :name, presence: true
end
