class Role < ApplicationRecord
  belongs_to :plan
  validates_presence_of :name, :description
end
