require 'rails_helper'

RSpec.describe Vision, type: :model do
  let!(:user) {FactoryBot.create(:user)}

  context "Validation tests" do
    it "Requires where_im_going" do
      vision_test = Vision.new(where_arrive:"where", how_complete_mission: "how", user_id: user.id).save
      expect(vision_test).to eq(false)
    end
    it "Requires where_arrive" do
      vision_test = Vision.new(where_im_going:"where1", how_complete_mission: "how", user_id: user.id).save
      expect(vision_test).to eq(false)
    end
    it "Requires how_complete_mission" do
      vision_test = Vision.new(where_im_going:"where1", where_arrive:"where", user_id: user.id).save
      expect(vision_test).to eq(false)
    end
    it "Should save successfully" do
      vision_test = Vision.new(where_im_going:"where1", where_arrive:"where", how_complete_mission: "how", user_id: user.id).save
      expect(vision_test).to eq(true)
    end
  end
end
