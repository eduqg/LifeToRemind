class Vision < ApplicationRecord
  belongs_to :user
  validates_presence_of :where_im_going, :where_arrive, :how_complete_mission
  validates :user, uniqueness: { scope: [:where_im_going, :where_arrive, :how_complete_mission], message: "Você já possui essa Visão" }
end
