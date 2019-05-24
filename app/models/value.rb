class Value < ApplicationRecord
  belongs_to :plan
  validates_presence_of :name
end
