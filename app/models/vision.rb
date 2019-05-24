class Vision < ApplicationRecord
  belongs_to :user
  validates_presence_of :where_im_going, :where_arrive, :how_complete_mission
end
